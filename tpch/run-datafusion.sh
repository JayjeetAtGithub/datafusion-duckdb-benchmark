#!/bin/bash
set -e

git clone https://github.com/apache/arrow-datafusion
cd arrow-datafusion
git checkout 29.0.0
cd benchmarks

./bench.sh data tpch
./bench.sh run tpch
