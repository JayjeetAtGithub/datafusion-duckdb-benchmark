#!/bin/bash


# create file
CREATE=${CREATE:-create-single-datafusion.sql}
DATAFUSION_CLI=${DATAFUSION_CLI:-datafusion-cli}
TRIES=3
QUERY_NUM=1
echo "Using ${DATAFUSION_CLI} $CREATE, appending results to result.csv"

echo "**********" >> result.csv
echo "$DATAFUSION_CLI" >> result.csv
echo "$CREATE" >> result.csv
echo `date` >> result.csv
echo "**********" >> result.csv
echo "Query,parallelism,iteration,time" >> result.csv

cat queries-datafusion.sql | while read query; do
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null

    echo "$query" > /tmp/query.sql
    echo "qnum: $QUERY_NUM"
    echo "$query"

    echo -n "["

    for c in 1 2 4 8; do
        echo "parallelism: $c"
        export DATAFUSION_EXECUTION_TARGET_PATITIONS=$c
        for i in $(seq 1 $TRIES); do
            # 1. there will be two query result, one for creating table another for executing the select statement
            # 2. each query contains a "Query took xxx seconds", we just grep these 2 lines
            # 3. use sed to take the second line
            # 4. use awk to take the number we want
            RES=`${DATAFUSION_CLI} -f ${CREATE} /tmp/query.sql 2>&1 | grep "Query took" | sed -n 2p | awk '{print $7}'`
            [[ $RES != "" ]] && \
                echo -n "$RES" || \
                echo -n "null"
            [[ "$i" != $TRIES ]] && echo -n ", "

        echo "${QUERY_NUM},${c},${i},${RES}" >> result.csv
        done
    done

    echo "],"

    QUERY_NUM=$((QUERY_NUM + 1))
done
