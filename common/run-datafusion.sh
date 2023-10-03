#!/bin/bash

# Runs all queries in a file using datafusion
#
# Usage:
# .run-datafusion.sh <setup.sql> <queries.sql> <sweep_cores> <result.csv>
#
# sweep_cores := is single|multi
#
# Example:
# bash .run-datafusion.sh create-multi-datafusion.sql queries-datafusion.sql multi clickbench_datafusion.csv

# create file
CREATE=$1
QUERIES=$2
SWEEP_CORES=$3
RESULT_FILE=$4
TRIES=5
QUERY_NUM=1

echo "Using ${CREATE}, appending results to ${RESULT_FILE}"

python3 -m venv `pwd`/venv
source venv/bin/activate
# installed as part of setup
# pip install --upgrade datafusion==31.0.0

cat ${QUERIES} | while read query; do
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
    sync

    echo "qnum: $QUERY_NUM"
    ../common/run-query-datafusion.py $CREATE $QUERY_NUM $SWEEP_CORES ${RESULT_FILE} <<< "${query}" | tee /tmp/datafusion.log

    QUERY_NUM=$((QUERY_NUM + 1))
done
