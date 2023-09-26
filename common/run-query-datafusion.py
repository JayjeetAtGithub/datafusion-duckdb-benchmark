#!/usr/bin/env python3

import sys
import timeit

from datafusion import SessionContext


if __name__ == "__main__":
    query = sys.stdin.read()
    print(query)

    # create a DataFusion context
    ctx = SessionContext()

    # invoke like run-datafusion-query.py 1 << "txt of q1"
    query_num = sys.argv[1]
    sweep_cores = sys.argv[2]
    result_file = sys.argv[3]

    if sweep_cores == "multi":
        cores = [1, 2, 4, 8, 16, 32, 64, 128]
    else:
        cores = [1]

    for c in cores:
        for try_num in range(1, 6):
            start = timeit.default_timer()
            df = ctx.sql(query)
            end = timeit.default_timer()

            # omit the first 2 cold starts
            if try_num > 2:
                print(end-start)
                # Append (query,iteration,time)
                with open(result_file, "a") as myfile:
                    time = (end - start)
                    myfile.write("{},{},{},{}\n".format(query_num, c, try_num, time))
