#!/bin/bash
set -ex

mode=$1 # single/multi
sweep_cores=$2 # single/multi

rm -rf datafusion.csv
rm -rf duckdb.csv

CREATE=create-$mode-duckdb.sql  bash run-duckdb.sh $sweep_cores
CREATE=create-$mode-datafusion.sql  bash run-datafusion.sh $sweep_cores
