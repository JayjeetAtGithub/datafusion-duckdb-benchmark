#!/bin/bash
set -e

./setup.sh
./run-duckdb.sh
./run-datafusion.sh
