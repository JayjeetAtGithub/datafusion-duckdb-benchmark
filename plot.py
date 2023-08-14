import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

import sys

if __name__ == "__main__":
    sns.set_theme(style="whitegrid")
    dbs = ["datafusion_main", "duckdb_main"]

    for db in dbs:
        data = {
            "query_no": list(),
            "cores": list(),
            "duration": list()   
        }
        with open(f'experiments/v1/{db}.csv') as f:
            lines = f.readlines()

        for line in lines:
            line = line.strip()
            line = line.split(',')
            query_no = int(line[0])
            cores = int(line[1])
            iteration = int(line[2])
            duration = float(line[3])

            data["query_no"].append(query_no)
            data["cores"].append(cores)
            data["duration"].append(duration)

        df = pd.DataFrame(data)
        sns.barplot(x="query_no", errwidth=1, capsize=0.1, errorbar="sd", y="duration", hue="cores", data=df)
        plt.xlabel("Query No.")
        plt.ylabel("Duration (s)")
        plt.title(f"{db} query scaling")
        plt.tight_layout()
        plt.show()
        plt.clf()
        plt.cla()
