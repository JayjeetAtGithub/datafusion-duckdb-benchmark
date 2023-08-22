#!/bin/bash


# create file
CREATE=${CREATE:-create-single-datafusion.sql}
DATAFUSION_CLI=${DATAFUSION_CLI:-datafusion-cli}
TRIES=5
QUERY_NUM=1
RESULT_FILE=h2o_datafusion.csv
sweep_cores=$1

echo "Using ${DATAFUSION_CLI} $CREATE, appending results to ${RESULT_FILE}"

cat queries-datafusion.sql | while read query; do
    sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
    sync

    echo "$query" > /tmp/query.sql
    echo "qnum: $QUERY_NUM"
    echo "$query"

    if [ "$sweep_cores" == "multi" ]; then
        core_arr=(1 2 4 8 16 32 64 128)
    else
        core_arr=(1)
    fi

    for c in ${core_arr[@]}; do
        echo -n "["
        for i in $(seq 1 $TRIES); do
            RES=`DATAFUSION_EXECUTION_TARGET_PARTITIONS=${c} ${DATAFUSION_CLI} -f ${CREATE} /tmp/query.sql 2>&1 | grep "Query took" | sed -n 2p | awk '{print $7}'`
            
            # omit the first 2 cold starts
            if [[ $i -gt 2 ]]; then
                [[ $RES != "" ]] && \
                    echo -n "$RES" || \
                    echo -n "null"
                [[ "$i" != $TRIES ]] && echo -n ", "

                echo "${QUERY_NUM},${c},${i},${RES}" >> ${RESULT_FILE}
            fi
        done
        echo "],"
    done

    QUERY_NUM=$((QUERY_NUM + 1))
done
