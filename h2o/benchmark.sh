#!/bin/bash
set -e

sweep_cores="${1:-single}" # single/multi


mkdir -p ../results/latest
rm -rf ../results/latest/h2o_datafusion.csv
rm -rf ../results/latest/h2o_duckdb.csv

bash ../common/run-datafusion.sh create-single-datafusion.sql queries-datafusion.sql $sweep_cores ../results/latest/h2o_datafusion.csv
bash ../common/run-duckdb.sh create-single-duckdb.sql queries-duckdb.sql $sweep_cores ../results/latest/h2o_duckdb.csv
