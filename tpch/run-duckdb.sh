#!/bin/bash
set -e

pwd=$(pwd)
cd ../duckdb
git checkout v0.8.1
build/release/benchmark/benchmark_runner --out=tpch_duckdb.out --threads=1 "benchmark/tpch/sf1/.*"
cp tpch_duckdb.out ${pwd}/tpch_duckdb.out
