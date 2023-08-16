import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

import sys

if __name__ == "__main__":
    sns.set_theme(style="whitegrid", palette="bright")

    engines = ["datafusion", "duckdb"]
    fig, axes = plt.subplots(3, 4, sharex=True, figsize=(20, 10))
    fig.text(0.5, 0.04, 'Cores', ha='center')
    fig.text(0.09, 0.5, 'Query Duration (s)', va='center', rotation='vertical')
    data = {}

    for engine in engines:
        with open(f'experiments/v1/{engine}.csv') as f:
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
        g = sns.lineplot(ax=axes.flat[ax_idx], x="cores", err_style="band", errorbar="sd", y="duration", hue="engine", markers=True, dashes=False, style="engine", data=df)
        g.set_xticklabels([1, 2, 4, 8, 16, 32, 64, 128])
        g.set(xlabel=None, ylabel=None)
        axes.flat[ax_idx].set_title(f"Query {k}")
        ax_idx += 1

    plt.savefig("scalability.pdf", bbox_inches='tight')