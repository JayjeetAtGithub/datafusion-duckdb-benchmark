#!/bin/bash
set -e

CREATE=${CREATE:-create-multi-datafusion.sql}

cat queries-datafusion.sql | while read query; do
    echo "$query" > /tmp/query.sql
    echo "$query"
    datafusion-cli -f ${CREATE} /tmp/query.sql
done
