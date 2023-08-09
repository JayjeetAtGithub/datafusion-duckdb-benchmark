import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

if __name__ == "__main__":

    data = {
        "query_no": list(),
        "cores": list(),
        "duration": list()   
    }

    with open('result.csv') as f:
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
    sns.barplot(x="query_no", y="duration", hue="cores", data=df)
    plt.show()
