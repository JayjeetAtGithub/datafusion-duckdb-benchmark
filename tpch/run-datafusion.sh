#!/bin/bash
set -e

pwd=$(pwd)
cd ../arrow-datafusion
git checkout 31.0.0
cd benchmarks

./bench.sh data tpch
./bench.sh run tpch
cd ${pwd}

cp ../arrow-datafusion/benchmarks/results/HEAD/tpch.json tpch_datafusion.json
