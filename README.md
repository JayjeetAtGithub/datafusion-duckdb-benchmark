# DataFusion / DuckDB Benchmarking Scripts

Benchmarking DataFusion and DuckDB over [ClickBench](https://benchmark.clickhouse.com), [TPC-H](https://www.tpc.org/tpch/default5.asp), and [H2O.ai](https://h2oai.github.io/db-benchmark/)

## Versions
* DataFusion 29.0.0
* DuckDB 0.8.1

## Setting up the Environment

```bash
# install datafusion
git clone https://github.com/apache/arrow-datafusion.git
cd datafusion
git checkout 29.0.0
cargo install --path datafusion-cli

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

# Run the benchmarks. Results will be written to clickbench_datafusion.csv and clickbench_duckdb.csv
bash benchmark.sh [dataset_type (single/multi)] [cores (single/multi)]

# Plot the results. Supports scalability and simple comparison charts
python3 plot.py [scalability/comparison]
```

## H2O.ai

```bash
cd h2o/

# Download the dataset
bash setup.sh

# Run the benchmarks. Results will be written to h2o_datafusion.csv and h2o_duckdb.csv
bash benchmark.sh [cores (single/multi)]

# Plot the results. Currently supports only single comparison charts
python3 plot.py
```

## TPC-H


```bash
cd tpch/

# Run the benchmarks
./run-datafusion.sh
./run-duckdb.sh

# Plot the results
python3 plot.py
```
