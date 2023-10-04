#!/bin/bash
set -e

# single = single parquet file (hits.parquet)
# multi = multiple parquet files (100 files in hits_multi)
# Use the multi-file dataset
mode="multi"

# single = single core
# multi = sweep multiple cores
sweep_cores="${1:-single}"

mkdir -p ../results/latest
rm -rf ../results/latest/clickbench_datafusion.csv
rm -rf ../results/latest/clickbench_duckdb.csv

bash ../common/run-datafusion.sh create-$mode-datafusion.sql queries-datafusion.sql $sweep_cores ../results/latest/clickbench_datafusion.csv
bash ../common/run-duckdb.sh create-$mode-duckdb.sql queries-duckdb.sql $sweep_cores ../results/latest/clickbench_duckdb.csv
