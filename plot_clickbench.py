import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

import sys

if __name__ == "__main__":
    plot_type = str(sys.argv[1])
    engines = ["datafusion", "duckdb"]
    sns.set_theme(style="whitegrid", palette="bright")

    if plot_type == "scalability":
        fig, axes = plt.subplots(3, 4, sharex=True, figsize=(20, 10))
        fig.text(0.5, 0.04, 'Cores', ha='center')
        fig.text(0.09, 0.5, 'Query Duration (s)', va='center', rotation='vertical')
        data = {}

        for engine in engines:
            with open(f'experiments/clickbench/{engine}.csv') as f:
                lines = f.readlines()

            for line in lines:
                line = line.strip()
                line = line.split(',')
                query_no = int(line[0])
                cores = int(line[1])
                iteration = int(line[2])
                duration = float(line[3])

                if data.get(query_no, None) == None:
                    data[query_no] = [{
                        "engine": engine,
                        "cores": cores,
                        "duration": duration,
                    }]
                else:
                    data[query_no].append({
                        "engine": engine,
                        "cores": cores,
                        "duration": duration,
                    })
        
        print(data)
        print(len(data))

        ax_idx = 0
        for k, v in data.items():
            df = pd.DataFrame(v)
            g = sns.pointplot(ax=axes.flat[ax_idx], x="cores", errorbar="sd", y="duration", hue="engine", data=df)
            g.set(xlabel=None, ylabel=None)
            g.set_yscale("log")
            axes.flat[ax_idx].set_title(f"Query {k}")
            axes.flat[ax_idx].xaxis.grid(True)
            axes.flat[ax_idx].yaxis.grid(True)
            ax_idx += 1

        plt.savefig(f"{plot_type}.pdf", bbox_inches='tight')
    
    elif plot_type == "comparison":
        data = {
            "duration": [],
            "engine": [],
            "query": [],
        }

        for engine in engines:
            with open(f'experiments/clickbench/{engine}.csv') as f:
                    lines = f.readlines()

            for line in lines:
                    line = line.strip()
                    line = line.split(',')
                    query_no = int(line[0])
                    cores = int(line[1])
                    iteration = int(line[2])
                    duration = float(line[3])

                    data["duration"].append(duration)
                    data["engine"].append(engine)
                    data["query"].append(query_no)

        df = pd.DataFrame(data)
        g = sns.barplot(x="query", y="duration", errorbar="sd", errwidth=0.1, capsize=0.2, hue="engine", data=df)
        g.set(xlabel="Query", ylabel="Duration (s)")
        plt.savefig(f"{plot_type}.pdf", bbox_inches='tight')
