#!/bin/bash
set -e

pwd=$(pwd)
cd ../arrow-datafusion
git checkout 31.0.0

scale_factor=$1

if [ "$scale_factor" == 1 ]; then
    ./benchmarks/bench.sh data tpch
elif [ "$scale_factor" == 10 ]; then
    ./benchmarks/bench.sh data tpch10
else 
    echo "Invalid scale factor: $scale_factor"
    exit 1
fi
