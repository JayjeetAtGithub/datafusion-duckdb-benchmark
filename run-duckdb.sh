#!/bin/bash

# create file
CREATE=${CREATE:-create-single-duckdb.sql}
TRIES=3
QUERY_NUM=1
echo "Using $CREATE, appending results to result.csv"

source venv/bin/activate

echo "**********" >> result.csv
echo "duckdb"
echo "$CREATE" >> result.csv
python -c 'import duckdb; print("duckdb {}".format(duckdb.__version__))' >> result.csv
echo `date` >> result.csv
echo "**********" >> result.csv
echo "Query,parallelism,iteration,time" >> result.csv

# clean out old database
rm -f my-db.duckdb*

cat ${CREATE} | ./create-view-duckdb.py

cat queries-duckdb.sql | while read query; do
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null

    echo "qnum: $QUERY_NUM"
    ./run-query-duckdb.py $QUERY_NUM  <<< "${query}" | tee /tmp/duckdb.log

    #echo "${QUERY_NUM},${i},${RES}" >> result.csv
#done
#    echo "],"

    QUERY_NUM=$((QUERY_NUM + 1))
done
