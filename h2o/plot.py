import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

import sys

if __name__ == "__main__":
    engines = ["duckdb", "datafusion"]
    sns.set_theme(style="whitegrid", palette="bright")
   
    plt.figure(figsize=(15,5))

    data = {
        "duration": [],
        "engine": [],
        "query": [],
    }

    for engine in engines:
        with open(f'h2o_{engine}.csv') as f:
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
    plt.savefig(f"comparison.h2o.pdf", bbox_inches='tight')
