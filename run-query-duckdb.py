#!/usr/bin/env python3

import duckdb
import timeit
import psutil
import sys

query = sys.stdin.read()
print(query)

con = duckdb.connect(database="my-db.duckdb", read_only=False)
# enable parquet metadata cache
con.execute("PRAGMA enable_object_cache")

# invoke like run-duckdb-query.py 1 << "txt of q1"
query_num = sys.argv[1]
sweep_cores = sys.argv[2]

if sweep_cores == "yes":
    cores = [1, 2, 4, 8, 16, 32, 64, 128]
else:
    cores = [1]

for c in cores:
    for try_num in range(1, 6):
        # set number of cores
        con.execute("PRAGMA threads={}".format(c))
        start = timeit.default_timer()
        results = con.execute(query).fetchall()
        end = timeit.default_timer()

        # omit the first 2 cold starts
        if try_num > 2:
            print(end-start)
            # Append (query,iteration,time)
            with open("duckdb.csv", "a") as myfile:
                time = (end - start)
                myfile.write("{},{},{},{}\n".format(query_num, c, try_num, time))
