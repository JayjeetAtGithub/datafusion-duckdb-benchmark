#!/bin/bash
set -e

mode="${1:-single}" # single/multi
sweep_cores="${2:-single}" # single/multi

rm -rf clickbench_datafusion.csv
rm -rf clickbench_duckdb.csv

bash ../commom/run-datafusion.sh create-$mode-datafusion.sql queries-datafusion.sql $sweep_cores clickbench_datafusion.csv
bash ../commom/run-duckdb.sh create-$mode-duckdb.sql queries-duckdb.sql $sweep_cores clickbench_duckdb.csv
