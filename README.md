# DataFusion / DuckDB Benchmarking Scripts

Benchmarking DataFusion and DuckDB over [ClickBench](https://benchmark.clickhouse.com), [TPC-H](https://www.tpc.org/tpch/default5.asp), and [H2O.ai](https://h2oai.github.io/db-benchmark/)

## Versions
* DataFusion 31.0.0
* DuckDB 0.8.1

## Results
All results are checked in to [results]

The scripts in this repository run queries via python bindings for both DataFusion and DuckDB

## Setting up the Environment

```bash

# Setup Python virtual environment and databases
python3 -m venv venv
source venv/bin/activate
pip install pyarrow pandas matplotlib seaborn

# install DuckDB
pip install duckdb==0.8.1 psutil

# install DataFusion
pip install --upgrade datafusion==31.0.0

```

## ClickBench

```bash
cd clickbench/

# Download the dataset
bash setup.sh

# The results are written to
#  ../results/latest/clickbench_datafusion.csv
#  ../results/latest/clickbench_duckdb.csv

bash benchmark.sh single
python3 plot.py comparison

# Run and plot scalability benchmarks
bash benchmark.sh multi multi
python3 plot.py scalability
```

## H2O.ai

```bash
cd h2o/

# Download the dataset
bash setup.sh

# Run the benchmarks. Results will be written to h2o_datafusion.csv and h2o_duckdb.csv
bash benchmark.sh [cores (single/multi)]

# Plot the results. Currently supports only comparison charts
python3 plot.py
```

## TPC-H

```bash
cd tpch/

# Download the dataset
bash setup.sh

# Run the benchmarks. Results will be written to tpch_datafusion.csv and tpch_duckdb.csv
bash benchmark.sh [cores (single/multi)]

# Plot the results. Currently supports only comparison charts
python3 plot.py
```

**Credits**: https://github.com/alamb/datafusion-duckdb-benchmark


## Appendix: Installing pre-release builds:

These instructions are for installing pre-release builds of DataFuson
and DuckDB for testing.

Work in progress


### DataFusion

```bash
# install datafusion
git clone https://github.com/apache/arrow-datafusion.git
git clone https://github.com/apache/arrow-datafusion-python.git

# follow instructions at https://github.com/apache/arrow-datafusion-python to build and install datafusion-python

# build with
maturin develop --release


cd arrow-datafusion
git checkout 31.0.0
cargo install --profile release --path datafusion-cli
```

### DuckDB

TODO: create pip binary
```bash
git clone https://github.com/duckdb/duckdb
cd duckdb
git checkout v0.8.1
BUILD_BENCHMARK=1 BUILD_TPCH=1 make -j$(nproc)
```
