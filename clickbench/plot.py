import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

import sys

if __name__ == "__main__":
    plot_type = str(sys.argv[1])
    engines = ["duckdb", "datafusion"]
    sns.set_theme(style="whitegrid", palette="bright")

    if plot_type == "scalability":
        fig, axes = plt.subplots(5, 8, sharex=True, figsize=(20, 10))
        fig.text(0.5, 0.04, 'Cores', ha='center')
        fig.text(0.08, 0.5, 'Query Duration (s)', va='center', rotation='vertical')
        data = {}

        for engine in engines:
            with open(f'clickbench_{engine}.csv') as f:
                lines = f.readlines()

            for line in lines:
                line = line.strip()
                line = line.split(',')
                query_no = int(line[0])
                cores = int(line[1])
                iteration = int(line[2])
                try:
                    duration = float(line[3])
                except:
                    duration = 0

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
            handles, labels = axes.flat[ax_idx].get_legend_handles_labels()
            axes.flat[ax_idx].get_legend().remove()
            ax_idx += 1
        
        fig.legend(handles, labels, loc='upper center')
        plt.savefig(f"{plot_type}.clickbench.pdf", bbox_inches='tight')

    elif plot_type == "comparison":
        plt.figure(figsize=(15,5))

        data = {
            "duration": [],
            "engine": [],
            "query": [],
        }

        for engine in engines:
            with open(f'clickbench_{engine}.csv') as f:
                    lines = f.readlines()

            for line in lines:
                line = line.strip()
                line = line.split(',')
                query_no = int(line[0])
                cores = int(line[1])
                iteration = int(line[2])
                try:
                    duration = float(line[3])
                except:
                    duration = 0

                data["duration"].append(duration)
                data["engine"].append(engine)
                data["query"].append(query_no)

        df = pd.DataFrame(data)
        g = sns.barplot(x="query", y="duration", errorbar="sd", errwidth=0.1, capsize=0.2, hue="engine", data=df)
        g.set(xlabel="Query", ylabel="Duration (s)")
        plt.savefig(f"{plot_type}.clickbench.pdf", bbox_inches='tight')
