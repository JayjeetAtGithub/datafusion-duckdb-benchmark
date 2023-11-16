# DataFusion / DuckDB Benchmarking Scripts

Compare DataFusion and DuckDB with
* [ClickBench](https://benchmark.clickhouse.com) - scripts in [clickbench](clickbench)
* [TPC-H](https://www.tpc.org/tpch/default5.asp) - scripts in [tpch]
* [H2O.ai](https://h2oai.github.io/db-benchmark/) - scripts in [h2o]

## Versions
* DataFusion 32.0.0
* DuckDB 0.9.1

## Results
All results are checked in to [results]

The scripts in this repository run queries via python bindings for both DataFusion and DuckDB

## Setting up the Environment

```bash

# Setup Python virtual environment and databases
python3 -m venv venv
source venv/bin/activate
pip install pyarrow pandas matplotlib seaborn prettytable

# install DuckDB
pip install duckdb==0.9.1 psutil

# install DataFusion
pip install datafusion==32.0.0

```

# Run all Benchmarks

```
bash benchmark-all.sh
```


**Credits**: https://github.com/alamb/datafusion-duckdb-benchmark
