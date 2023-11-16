Scripts for running TPCH benchmarks. See [Main Readme](../README.md) for details


## TPC-H
```bash
cd tpch/

# Download the dataset
bash setup.sh

# Run the benchmarks. Results will be written to
#  ../results/latest/clickbench_datafusion.csv
#  ../results/latest/clickbench_duckdb.csv
bash benchmark.sh

# Plot the results
python3 plot.py
```

## Run a single query


### DataFusion
```python
#!/usr/bin/env python3

import os
import sys
import timeit


from datafusion import SessionContext, SessionConfig, RuntimeConfig

create_queries = [
    "CREATE EXTERNAL TABLE customer STORED AS PARQUET LOCATION 'tpch_dataset/customer/part-0.parquet'",
    "CREATE EXTERNAL TABLE orders STORED AS PARQUET LOCATION 'tpch_dataset/orders/part-0.parquet'",
    "CREATE EXTERNAL TABLE lineitem STORED AS PARQUET LOCATION 'tpch_dataset/lineitem/part-0.parquet'",
    "CREATE EXTERNAL TABLE part STORED AS PARQUET LOCATION 'tpch_dataset/part/part-0.parquet'",
    "CREATE EXTERNAL TABLE partsupp STORED AS PARQUET LOCATION 'tpch_dataset/partsupp/part-0.parquet'",
    "CREATE EXTERNAL TABLE region STORED AS PARQUET LOCATION 'tpch_dataset/region/part-0.parquet'",
    "CREATE EXTERNAL TABLE supplier STORED AS PARQUET LOCATION 'tpch_dataset/supplier/part-0.parquet'",
    "CREATE EXTERNAL TABLE nation STORED AS PARQUET LOCATION 'tpch_dataset/nation/part-0.parquet'",
]

query = "SELECT COUNT(*) FROM lineitem";

# Thread Count
target_partitions = 1

config = SessionConfig().with_target_partitions(target_partitions)
ctx = SessionContext(config, RuntimeConfig())

# Create all EXTERNAL TABLES
for create_query in create_queries:
    ctx.sql(create_query)

print("Running query...")

# RUN query
start = timeit.default_timer()
result = ctx.sql(query).collect()
end = timeit.default_timer()
print("Results");
print(result)
print("Done in: {}".format(end - start))
```


### DuckDB

```python
#!/usr/bin/env python3

import duckdb
import timeit
import psutil
import sys

create_queries = [
    "CREATE VIEW customer AS SELECT * FROM read_parquet('tpch_dataset/customer/part-0.parquet')",
    "CREATE VIEW orders AS SELECT * FROM read_parquet('tpch_dataset/orders/part-0.parquet')",
    "CREATE VIEW lineitem AS SELECT * FROM read_parquet('tpch_dataset/lineitem/part-0.parquet')",
    "CREATE VIEW part AS SELECT * FROM read_parquet('tpch_dataset/part/part-0.parquet')",
    "CREATE VIEW partsupp AS SELECT * FROM read_parquet('tpch_dataset/partsupp/part-0.parquet')",
    "CREATE VIEW region AS SELECT * FROM read_parquet('tpch_dataset/region/part-0.parquet')",
    "CREATE VIEW supplier AS SELECT * FROM read_parquet('tpch_dataset/supplier/part-0.parquet')",
    "CREATE VIEW nation AS SELECT * FROM read_parquet('tpch_dataset/nation/part-0.parquet')",
]


query = "SELECT COUNT(*) FROM lineitem"

# Thread Count
num_threads = 1

duckdb.sql("PRAGMA threads={}".format(num_threads))


# Create all VIEWS
for create_query in create_queries:
    duckdb.sql(create_query)

print("Running query...")

# RUN query
start = timeit.default_timer()
result = duckdb.sql(query)
print("Results");
print(result) # have to use the results otherwise query doesn't run
end = timeit.default_timer()
print("Done in: {}".format(end - start))
```


### DataFusion SQL

```sql
CREATE EXTERNAL TABLE customer STORED AS PARQUET LOCATION 'tpch_dataset/customer/part-0.parquet';
CREATE EXTERNAL TABLE orders STORED AS PARQUET LOCATION 'tpch_dataset/orders/part-0.parquet';
CREATE EXTERNAL TABLE lineitem STORED AS PARQUET LOCATION 'tpch_dataset/lineitem/part-0.parquet';
CREATE EXTERNAL TABLE part STORED AS PARQUET LOCATION 'tpch_dataset/part/part-0.parquet';
CREATE EXTERNAL TABLE partsupp STORED AS PARQUET LOCATION 'tpch_dataset/partsupp/part-0.parquet';
CREATE EXTERNAL TABLE region STORED AS PARQUET LOCATION 'tpch_dataset/region/part-0.parquet';
CREATE EXTERNAL TABLE supplier STORED AS PARQUET LOCATION 'tpch_dataset/supplier/part-0.parquet';
CREATE EXTERNAL TABLE nation STORED AS PARQUET LOCATION 'tpch_dataset/nation/part-0.parquet';

set datafusion.execution.target_partitions = 1;

explain analyze select	o_orderpriority,	count(*) as order_count	from	orders	where	o_orderdate >= '1993-07-01'	and o_orderdate < date '1993-07-01' + interval '3' month	and exists (	select	*	from	lineitem	where	l_orderkey = o_orderkey	and l_commitdate < l_receiptdate	)	group by	o_orderpriority	order by	o_orderpriority;
```
