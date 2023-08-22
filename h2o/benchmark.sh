#!/bin/bash
set -e

rm -rf h2o_datafusion.csv 
rm -rf h2o_duckdb.csv

./run-duckdb.sh
./run-datafusion.sh
