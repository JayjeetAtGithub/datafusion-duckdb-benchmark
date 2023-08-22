#!/bin/bash
set -e

rm -rf h2o_datafusion.csv h2o_duckdb.csv

rm -rf G1_1e7_1e2_5_0.csv*
wget https://github.com/duckdb/duckdb-data/releases/download/v1.0/G1_1e7_1e2_5_0.csv.gz
gunzip G1_1e7_1e2_5_0.csv.gz

python3 -m venv `pwd`/venv
