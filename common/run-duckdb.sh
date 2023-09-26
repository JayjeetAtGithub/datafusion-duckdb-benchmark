#!/bin/bash

# create file
CREATE=${CREATE:-create-single-duckdb.sql}
QUERIES=$1
SWEEP_CORES=$2
RESULT_FILE=$3
TRIES=5
QUERY_NUM=1

echo "Using ${CREATE}, appending results to ${RESULT_FILE}"

python3 -m venv `pwd`/venv
source venv/bin/activate
pip install duckdb==0.9.0 psutil

# clean out old database
rm -f *.duckdb*

cat ${CREATE} | ../common/create-view-duckdb.py

cat ${QUERIES} | while read query; do
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
    sync

    echo "qnum: $QUERY_NUM"
    ../common/run-query-duckdb.py $QUERY_NUM $SWEEP_CORES ${RESULT_FILE} <<< "${query}" | tee /tmp/duckdb.log

    QUERY_NUM=$((QUERY_NUM + 1))
done
