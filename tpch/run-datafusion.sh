#!/bin/bash
set -e

cd ../arrow-datafusion
git checkout 29.0.0
cd benchmarks

./bench.sh data tpch
./bench.sh run tpch
