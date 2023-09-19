#!/bin/bash
set -e

pwd=$(pwd)
cd ../arrow-datafusion
git checkout 31.0.0
./benchmarks/bench.sh data tpch
