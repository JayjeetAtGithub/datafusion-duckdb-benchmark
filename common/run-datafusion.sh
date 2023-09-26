#!/bin/bash

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
pip install --upgrade datafusion==31.0.0

cat ${QUERIES} | while read query; do
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
    sync

    echo "qnum: $QUERY_NUM"
    ../common/run-query-datafusion.py $CREATE $QUERY_NUM $SWEEP_CORES ${RESULT_FILE} <<< "${query}" | tee /tmp/datafusion.log

    QUERY_NUM=$((QUERY_NUM + 1))
done
