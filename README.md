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
pip install pyarrow pandas matplotlib seaborn prettytable

# install DuckDB
pip install duckdb==0.9.0 psutil

# install DataFusion
pip install --upgrade datafusion==31.0.0

```

# Run all Benchmarks

```
bash benchmark-all.sh
```

## ClickBench

```bash
cd clickbench/

# Download the dataset
bash setup.sh

# Run the benchmark,  results are written to
#  ../results/latest/clickbench_datafusion.csv
#  ../results/latest/clickbench_duckdb.csv
bash benchmark.sh single

# Plot the results, written to
# ../results/latest/comparison.clickbench.pdf
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
bash benchmark.sh

# Plot the results. Currently supports only comparison charts
python3 plot.py
```

## TPC-H
```bash
cd tpch/

# Download the dataset
bash setup.sh

# Run the benchmarks. Results will be written to
#  ../results/latest/clickbench_datafusion.csv
#  ../results/latest/clickbench_duckdb.csv
bash benchmark.sh

# Plot the results
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

cd arrow-datafusion
git checkout main
# optionally install datafusion-cli
# cargo install --profile release --path datafusion-cli
```

Apply a patch to use the local checkout


```diff
diff --git a/Cargo.toml b/Cargo.toml
index 5ca3eee..c4a0418 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -35,13 +35,19 @@ protoc = [ "datafusion-substrait/protoc" ]
 [dependencies]
 tokio = { version = "1.24", features = ["macros", "rt", "rt-multi-thread", "sync"] }
 rand = "0.8"
-pyo3 = { version = "0.18.1", features = ["extension-module", "abi3", "abi3-py37"] }
-datafusion = { version = "22.0.0", features = ["pyarrow", "avro"] }
-datafusion-common = { version = "22.0.0", features = ["pyarrow"] }
-datafusion-expr = { version = "22.0.0" }
-datafusion-optimizer = { version = "22.0.0" }
-datafusion-sql = { version = "22.0.0" }
-datafusion-substrait = { version = "22.0.0" }
+pyo3 = { version = "0.19", features = ["extension-module", "abi3", "abi3-py37"] }
+#datafusion = { version = "22.0.0", features = ["pyarrow", "avro"] }
+#datafusion-common = { version = "22.0.0", features = ["pyarrow"] }
+#datafusion-expr = { version = "22.0.0" }
+#datafusion-optimizer = { version = "22.0.0" }
+#datafusion-sql = { version = "22.0.0" }
+#datafusion-substrait = { version = "22.0.0" }
+datafusion = { path = "/home/alamb/arrow-datafusion/datafusion/core", features = ["pyarrow", "avro"] }
+datafusion-common = { path = "/home/alamb/arrow-datafusion/datafusion/common", features = ["pyarrow"] }
+datafusion-expr = { path = "/home/alamb/arrow-datafusion/datafusion/expr" }
+datafusion-optimizer = { path = "/home/alamb/arrow-datafusion/datafusion/optimizer" }
+datafusion-sql = { path = "/home/alamb/arrow-datafusion/datafusion/sql" }
+datafusion-substrait = { path = "/home/alamb/arrow-datafusion/datafusion/substrait" }
 uuid = { version = "1.2", features = ["v4"] }
 mimalloc = { version = "0.1", optional = true, default-features = false }
 async-trait = "0.1"
 ```

˘
Build by following instructions at https://github.com/apache/arrow-datafusion-python to build and install datafusion-python

Activate:
```shell
source venv/bin/activate
```

Ensure we have activated the correct venv

```shell
$ which python3
/home/alamb/datafusion-duckdb-benchmark/venv/bin/python3
```

Then build the wheel:

```
maturin build --release --sdist --out dist --features protoc
```

Which will result in building a wheel in `dist`:

```
📦 Built wheel for abi3 Python ≥ 3.8 to dist/datafusion-32.0.0rc0-cp38-abi3-manylinux_2_35_x86_64.whl
```


### DuckDB

TODO: create pip binary
```bash
git clone https://github.com/duckdb/duckdb
cd duckdb
git checkout v0.8.1
BUILD_BENCHMARK=1 BUILD_TPCH=1 make -j$(nproc)
```
