#!/bin/bash
set -e

sweep_cores="${1:-single}" # single/multi

rm -rf tpch_datafusion.csv 
rm -rf tpch_duckdb.csv

bash run-duckdb.sh $sweep_cores
bash run-datafusion.sh $sweep_cores
