#!/bin/bash
set -ex

rm -rf datafusion.csv
rm -rf duckdb.csv

CREATE=create-multi-datafusion.sql  bash run-datafusion.sh
CREATE=create-multi-duckdb.sql  bash run-duckdb.sh
