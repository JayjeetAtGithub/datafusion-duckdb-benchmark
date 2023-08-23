#!/bin/bash
set -e

PWD=$(pwd)
cd ../arrow-datafusion
git checkout 29.0.0
cd benchmarks

./bench.sh data tpch
./bench.sh run tpch
cd ${PWD}

cp ../arrow-datafusion/benchmarks/results/HEAD/tpch.json tpch_datafusion.json
