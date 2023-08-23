#!/bin/bash
set -e

git clone https://github.com/duckdb/duckdb
cd duckdb
git checkout v0.8.1
BUILD_BENCHMARK=1 BUILD_TPCH=1 make -j$(nproc)

build/release/benchmark/benchmark_runner --out=tpch_duckdb --threads=1 "benchmark/tpch/sf1/.*"
