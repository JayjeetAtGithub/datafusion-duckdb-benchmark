Scripts for running ClickBench benchmarks. See [Main Readme](../README.md) for details


## ClickBench

```bash
cd clickbench/

# Download the dataset
bash setup.sh

# Run the benchmark,  results are written to
#  ../results/latest/clickbench_datafusion.csv
#  ../results/latest/clickbench_duckdb.csv
bash benchmark.sh single

# Plot the results, written to
# ../results/latest/comparison.clickbench.pdf
python3 plot.py comparison

# Run and plot scalability benchmarks
bash benchmark.sh multi multi
python3 plot.py scalability
```

## Run a single query

### DataFusion

```python
#!/usr/bin/env python3

import os
import timeit

from datafusion import SessionContext, SessionConfig, RuntimeConfig

# Thread Count
target_partitions = 1

config = SessionConfig().with_target_partitions(target_partitions)
ctx = SessionContext(config, RuntimeConfig())

# Create Table
create_query = "CREATE EXTERNAL TABLE hits STORED AS PARQUET LOCATION 'hits_multi';"
result = ctx.sql(create_query).collect()

print("Running query...")

# Run query
query = """
SELECT DATE_TRUNC('minute', to_timestamp_seconds("EventTime")) AS M, COUNT(*) AS PageViews FROM hits WHERE "CounterID" = 62 AND "EventDate"::INT::DATE >= '2013-07-14' AND "EventDate"::INT::DATE <= '2013-07-15' AND "IsRefresh" = 0 AND "DontCountHits" = 0 GROUP BY DATE_TRUNC('minute', to_timestamp_seconds("EventTime")) ORDER BY DATE_TRUNC('minute', M) LIMIT 10 OFFSET 1000;
"""

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


query = "SELECT DATE_TRUNC('minute', EventTime) AS M, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-14' AND EventDate <= '2013-07-15' AND IsRefresh = 0 AND DontCountHits = 0 GROUP BY DATE_TRUNC('minute', EventTime) ORDER BY DATE_TRUNC('minute', EventTime) LIMIT 10 OFFSET 1000;"

# Thread Count
num_threads = 1

duckdb.sql("PRAGMA threads={}".format(num_threads))

# Create the view
create_query = """CREATE VIEW hits AS
SELECT *
	REPLACE
	(epoch_ms(EventTime * 1000) AS EventTime,
	 DATE '1970-01-01' + INTERVAL (EventDate) DAYS AS EventDate)
FROM read_parquet('hits_multi/hits_*.parquet', binary_as_string=True);
"""

duckdb.sql(create_query)

# Run query
print("Running query...")
start = timeit.default_timer()
result = duckdb.sql(query)
print("Results");
print(result) # have to use the results otherwise query doesn't run
end = timeit.default_timer()
print("Done in: {}".format(end - start))
```

### Datfusion SQL
```sql
CREATE EXTERNAL TABLE hits STORED AS PARQUET LOCATION 'hits_multi';

set datafusion.execution.target_partitions = 1;

SELECT DATE_TRUNC('minute', to_timestamp_seconds("EventTime")) AS M, COUNT(*) AS PageViews FROM hits WHERE "CounterID" = 62 AND "EventDate"::INT::DATE >= '2013-07-14' AND "EventDate"::INT::DATE <= '2013-07-15' AND "IsRefresh" = 0 AND "DontCountHits" = 0 GROUP BY DATE_TRUNC('minute', to_timestamp_seconds("EventTime")) ORDER BY DATE_TRUNC('minute', M) LIMIT 10 OFFSET 1000;

```
