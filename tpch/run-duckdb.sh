#!/bin/bash
set -e

PWD=$(pwd)
git clone https://github.com/duckdb/duckdb
cd duckdb
git checkout v0.8.1
BUILD_BENCHMARK=1 BUILD_TPCH=1 make -j$(nproc)

build/release/benchmark/benchmark_runner --out=tpch_duckdb.out --threads=1 "benchmark/tpch/sf1/.*"
cp tpch_duckdb.out ${PWD}/tpch_duckdb.out
