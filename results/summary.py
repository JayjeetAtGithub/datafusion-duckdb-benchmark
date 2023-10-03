from prettytable import PrettyTable

def read_file(file_path):
    data = dict()
    with open(file_path, "r") as f:
        lines = f.readlines()
        for line in lines:
            line = line.strip()
            query_no, no_threads, iteration, time = line.split(",")
            if no_threads == "1":
                try:
                    if query_no not in data:
                        data[query_no] = float(time)
                    else:
                        data[query_no] += float(time)
                except ValueError:
                    pass
    for k, v in data.items():
        data[k] = data[k] / 3
    return data


def fix_duckdb_results(datafusion_results, duckdb_results):
    new_duckdb_results = dict()
    for k in datafusion_results.keys():
        new_duckdb_results[k] = duckdb_results[k]
    return datafusion_results, new_duckdb_results


if __name__ == "__main__":
    benches = ["tpch", "h2o", "clickbench"]
    for bench in benches:
        table = list()
        datafusion_results = read_file(f"latest/{bench}_datafusion.csv")
        duckdb_results = read_file(f"latest/{bench}_duckdb.csv")

        datafusion_results, duckdb_results = fix_duckdb_results(datafusion_results, duckdb_results)

        print(f"{bench}: ")
        table.append(["Query", "DataFusion", "DuckDB", "Summary (Datafusion / DuckDB))"])
        for df_key, duck_key in zip(datafusion_results.keys(), duckdb_results.keys()):
            df_res = datafusion_results[df_key]
            duck_res = duckdb_results[duck_key]
            
            times = round(df_res / duck_res, 4)
            if times > 1:
                times = f"{round(times, 2)}x slower"
            else:
                times = f"{round(1/times, 2)}x faster"
            
            table.append([df_key, round(df_res, 2), round(duck_res, 2), times])

        tab = PrettyTable(table[0])
        tab.add_rows(table[1:])
        print(tab)
        print("\n")
