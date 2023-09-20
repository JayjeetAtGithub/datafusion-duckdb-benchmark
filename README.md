# DataFusion / DuckDB Benchmarking Scripts

Benchmarking DataFusion and DuckDB over [ClickBench](https://benchmark.clickhouse.com), [TPC-H](https://www.tpc.org/tpch/default5.asp), and [H2O.ai](https://h2oai.github.io/db-benchmark/)

## Versions
* DataFusion 31.0.0
* DuckDB 0.8.1

## Setting up the Environment

```bash
# install datafusion
git clone https://github.com/apache/arrow-datafusion.git
cd arrow-datafusion
git checkout 31.0.0
cargo install --profile release --path datafusion-cli

# install duckdb
git clone https://github.com/duckdb/duckdb
cd duckdb
git checkout v0.8.1
BUILD_BENCHMARK=1 BUILD_TPCH=1 make -j$(nproc)

# Setup Python virtual environment
python3 -m venv venv
source venv/bin/activate
pip install pyarrow pandas matplotlib seaborn
```

## ClickBench

```bash
cd clickbench/

# Download the dataset
bash setup.sh

# The results are written to tpch_datafusion.csv and tpch_duckdb.csv
# Run and plot comparison benchmarks
bash benchmark.sh single single
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

# Plot the results
python3 plot.py
```

**Credits**: https://github.com/alamb/datafusion-duckdb-benchmark
