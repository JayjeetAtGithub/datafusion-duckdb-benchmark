#!/usr/bin/env python3

import duckdb
import timeit
import psutil
import sys


if __name__ == "__main__":
    query = sys.stdin.read()
    print(query)

    con = duckdb.connect(database="my-db.duckdb", read_only=False)
    # enable parquet metadata cache
    con.execute("PRAGMA enable_object_cache")

    # invoke like run-duckdb-query.py 1 << "txt of q1"
    query_num = sys.argv[1]
    sweep_cores = sys.argv[2]
    result_file = sys.argv[3]

    if sweep_cores == "multi":
        cores = [1, 2, 4, 8, 16, 32, 64, 128, 192]
    else:
        cores = [1]

    for c in cores:
        for try_num in range(1, 6):
            # set number of cores
            con.execute("PRAGMA threads={}".format(c))
            start = timeit.default_timer()
            result = con.execute(query).fetchall()
            end = timeit.default_timer()
            print(end-start)

            # omit the first 2 cold starts
            if try_num > 2:
                # Append (query,iteration,time)
                with open(result_file, "a") as myfile:
                    time = (end - start)
                    myfile.write("{},{},{},{}\n".format(query_num, c, try_num, time))
