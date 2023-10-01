#!/usr/bin/env python3

import os
import sys
import timeit

from datafusion import SessionContext, SessionConfig, RuntimeConfig


if __name__ == "__main__":
    query = sys.stdin.read()
    print(query)

    # invoke like run-datafusion-query.py 1 << "txt of q1"
    create_query_file = sys.argv[1]
    query_num = sys.argv[2]
    sweep_cores = sys.argv[3]
    result_file = sys.argv[4]

    if sweep_cores == "multi":
        cores = [1, 2, 4, 8]
    else:
        cores = [1]

    for c in cores:
        # create a DataFusion context
        config = SessionConfig().with_target_partitions(c)
        ctx = SessionContext(config, RuntimeConfig())

        with open(create_query_file, "r") as f:
            create_queries = f.readlines()
            start = timeit.default_timer()
            for create_query in create_queries:
                ctx.sql(create_query)
            end = timeit.default_timer()
        
        print("Setup table: {}".format(end - start))

        for try_num in range(1, 6):
            start = timeit.default_timer()
            if query_num == "15" and result_file == "tpch_datafusion.csv":
                query_parts = query.split(";")[:-1]
                for query_part in query_parts:
                    result = ctx.sql(f"{query_part.strip()};").collect()
            else:
                result = ctx.sql(query).collect()
            end = timeit.default_timer()
            print(end-start)

            # omit the first 2 cold starts
            if try_num > 2:
                # Append (query,iteration,time)
                with open(result_file, "a") as myfile:
                    time = (end - start)
                    myfile.write("{},{},{},{}\n".format(query_num, c, try_num, time))
