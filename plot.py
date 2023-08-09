import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

if __name__ == "__main__":
    db = str(sys.argv[1])
    sns.set_theme(style="whitegrid")
    data = {
        "query_no": list(),
        "cores": list(),
        "duration": list()   
    }

    with open(f'{db}.csv') as f:
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
    plt.show()
