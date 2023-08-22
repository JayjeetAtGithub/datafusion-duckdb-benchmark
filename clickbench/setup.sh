#!/bin/bash
# Downloads parquet files (single and partitioned)'

echo "downloading hits_multi..."
mkdir -p hits_multi
pushd hits_multi
seq 0 99 | xargs -P100 -I{} bash -c 'wget -q --continue https://datasets.clickhouse.com/hits_compatible/athena_partitioned/hits_{}.parquet'
popd

echo "downloading hits..."
wget -q --continue https://datasets.clickhouse.com/hits_compatible/hits.parquet
