#!/bin/bash

# create file
CREATE=${CREATE:-create-single-duckdb.sql}
TRIES=5
QUERY_NUM=1
RESULT_FILE=h2o_duckdb.csv
sweep_cores=$1

echo "Using $CREATE, appending results to ${RESULT_FILE}"

source venv/bin/activate

# clean out old database
rm -f *.duckdb*

cat ${CREATE} | ./common/create-view-duckdb.py

cat queries-duckdb.sql | while read query; do
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
    sync

    echo "qnum: $QUERY_NUM"
    ./common/run-query-duckdb.py $QUERY_NUM $sweep_cores $RESULT_FILE <<< "${query}" | tee /tmp/duckdb.log

    QUERY_NUM=$((QUERY_NUM + 1))
done
