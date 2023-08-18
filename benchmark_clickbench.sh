#!/bin/bash
set -ex

mode=$1 # single/multi
sweep_cores=$2 # yes/no

rm -rf datafusion.csv
rm -rf duckdb.csv

CREATE=create-$mode-datafusion.sql  bash run-datafusion.sh $sweep_cores
CREATE=create-$mode-duckdb.sql  bash run-duckdb.sh $sweep_cores
