import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import json
import sys

if __name__ == "__main__":
    sns.set_theme(style="whitegrid", palette="bright")
    plt.figure(figsize=(15,5))

    data = {
        "duration": [],
        "engine": [],
        "query": [],
    }
    
    # parsing duckdb
    with open('tpch_duckdb') as f:
        lines = f.readlines()

        curr_query = 1
        counter = 0
        print(len(lines))
        for line in lines:
            data["engine"].append("duckdb")
            data["duration"].append(float(line)*1000)
            data["query"].append(int(curr_query))
            counter += 1
            if counter % 5 == 0:
                curr_query += 1

        print(len(data["duration"]))
        print(len(data["engine"]))
        print(len(data["query"]))

    # parsing datafusion
    with open('datafusion.json') as f:
        datafusion_data = json.load(f)

        for query in datafusion_data["queries"]:
            for itr in query["iterations"]:
                data["duration"].append(float(itr["elapsed"]))
                data["engine"].append("datafusion")
                data["query"].append(int(query["query"].split(" ")[1]))

    df = pd.DataFrame(data)
    g = sns.barplot(x="query", y="duration", errorbar="sd", errwidth=0.1, capsize=0.2, hue="engine", data=df)
    g.set(xlabel="Query", ylabel="Duration (ms)")
    plt.title("TPC-H Benchmark")
    plt.savefig(f"comparison.tpch.pdf", bbox_inches='tight')
