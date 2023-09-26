#!/bin/bash
set -e

sweep_cores="${1:-single}" # single/multi

rm -rf tpch_datafusion.csv 
rm -rf tpch_duckdb.csv

bash ../common/run-datafusion.sh create-single-datafusion.sql queries.sql $sweep_cores tpch_datafusion.csv
bash ../common/run-duckdb.sh create-single-duckdb.sql queries.sql $sweep_cores tpch_duckdb.csv
