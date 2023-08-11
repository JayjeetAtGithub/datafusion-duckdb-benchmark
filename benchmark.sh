#!/bin/bash
set -ex

# Runs several benchmark

# DATAFUSION_CLI=./datafusion-cli.28.0.0 CREATE=create-single-datafusion.sql bash run-datafusion.sh
# CREATE=create-single-duckdb.sql bash run-duckdb.sh

# note need to run this with q34 commented out
# DATAFUSION_CLI=./datafusion-cli.27.0.0 CREATE=create-single-datafusion.sql bash run-datafusion.sh

## This is multi file
## DataFusion fails due to https://github.com/apache/arrow-datafusion/issues/7039

#CREATE=create-multi-duckdb.sql  bash run-duckdb.sh
#DATAFUSION_CLI=./datafusion-cli.28.0.0 CREATE=create-multi-datafusion.sql  bash run-datafusion.sh
#DATAFUSION_CLI=./datafusion-cli.27.0.0 CREATE=create-multi-datafusion.sql  bash run-datafusion.sh


rm -rf datafusion.csv
rm -rf duckdb.csv

CREATE=create-multi-datafusion.sql  bash run-datafusion.sh
CREATE=create-multi-duckdb.sql  bash run-duckdb.sh
