#!/bin/bash
set -e

sweep_cores="${1:-single}" # single/multi

rm -rf h2o_datafusion.csv 
rm -rf h2o_duckdb.csv

bash ../common/run-datafusion.sh create-single-datafusion.sql queries-datafusion.sql $sweep_cores h2o_datafusion.csv
bash ../common/run-duckdb.sh create-single-duckdb.sql queries-duckdb.sql $sweep_cores h2o_duckdb.csv
