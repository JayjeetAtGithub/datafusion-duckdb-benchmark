#!/bin/bash
set -e

sweep_cores="${1:-single}" # single/multi

rm -rf tpch_datafusion.csv 
rm -rf tpch_duckdb.csv

bash run-datafusion.sh $sweep_cores
