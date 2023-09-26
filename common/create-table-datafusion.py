#!/usr/bin/env python3

import sys
import timeit

from datafusion import SessionContext


if __name__ == "__main__":
    # Create a DataFusion context
    ctx = SessionContext()

    # Read query from stdin
    query = sys.stdin.read()

    start = timeit.default_timer()
    ctx.sql(query)
    end = timeit.default_timer()
    print(end - start)
