Scripts for running H20.ai Group benchmarks. See [Main Readme](../README.md) for details

## H2O.ai

```bash
cd h2o/

# Download the dataset
bash setup.sh

# Run the benchmarks. Results will be written to h2o_datafusion.csv and h2o_duckdb.csv
bash benchmark.sh

# Plot the results. Currently supports only comparison charts
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

query = "select id1, id2, id3, id4, id5, id6, sum(v3) as v3, count(*) as count from h2o group by id1, id2, id3, id4, id5, id6;"

# Thread Count
target_partitions = 1

config = SessionConfig().with_target_partitions(target_partitions)
ctx = SessionContext(config, RuntimeConfig())

# Create Table
create_query = "CREATE EXTERNAL TABLE h2o (id1  VARCHAR,id2  VARCHAR,id3  VARCHAR,id4  INT,id5  INT,id6  INT,v1  INT,v2 INT,v3 DOUBLE) STORED AS CSV WITH HEADER ROW LOCATION 'G1_1e7_1e2_5_0.csv'"
result = ctx.sql(create_query).collect()

print("Running query...")


# RUN query
start = timeit.default_timer()
result = ctx.sql(query).collect()
end = timeit.default_timer()
print("Results");
#print(result)
print("Done in: {}".format(end - start))
```


### DuckDB

```python
#!/usr/bin/env python3

import duckdb
import timeit
import psutil
import sys

create_query = "CREATE VIEW h2o AS SELECT * FROM read_csv_auto('G1_1e7_1e2_5_0.csv');"


query = "select id1, id2, id3, id4, id5, id6, sum(v3) as v3, count(*) as count from h2o group by id1, id2, id3, id4, id5, id6;"

# Thread Count
num_threads = 1

duckdb.sql("PRAGMA threads={}".format(num_threads))


# Create all VIEWS
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

### Datfusion SQL

```sql
CREATE EXTERNAL TABLE h2o (id1  VARCHAR,id2  VARCHAR,id3  VARCHAR,id4  INT,id5  INT,id6  INT,v1  INT,v2 INT,v3 DOUBLE) STORED AS CSV WITH HEADER ROW LOCATION 'G1_1e7_1e2_5_0.csv';

set datafusion.execution.target_partitions = 1;

select id1, id2, id3, id4, id5, id6, sum(v3) as v3, count(*) as count from h2o group by id1, id2, id3, id4, id5, id6;
```
