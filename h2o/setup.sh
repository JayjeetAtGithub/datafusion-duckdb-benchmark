#!/bin/bash
set -e

# 500M dataset

# group by (`x`) dataset (500M)
rm -rf G1_1e7_1e2_5_0.csv*
wget https://github.com/duckdb/duckdb-data/releases/download/v1.0/G1_1e7_1e2_5_0.csv.gz
gunzip G1_1e7_1e2_5_0.csv.gz

# join small dataset
rm -rf J1_1e7_NA_0_0.csv*
wget https://github.com/duckdb/duckdb-data/releases/download/v1.0/J1_1e7_NA_0_0.csv.gz
gunzip J1_1e7_NA_0_0.csv.gz

# Join "small" dataset 
rm -rf J1_1e7_1e1_0_0.csv*
wget https://github.com/duckdb/duckdb-data/releases/download/v1.0/J1_1e7_1e1_0_0.csv.gz
gunzip J1_1e7_1e1_0_0.csv.gz

rm -rf J1_1e7_1e4_0_0.csv*
wget https://github.com/duckdb/duckdb-data/releases/download/v1.0/J1_1e7_1e4_0_0.csv.gz
gunzip J1_1e7_1e4_0_0.csv.gz

rm -rf J1_1e7_1e7_0_0.csv*
wget https://github.com/duckdb/duckdb-data/releases/download/v1.0/J1_1e7_1e7_0_0.csv.gz
gunzip J1_1e7_1e7_0_0.csv.gz
