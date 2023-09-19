-- Single parquet file

CREATE EXTERNAL TABLE customer
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_1/customer';

CREATE EXTERNAL TABLE orders
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_1/orders';

CREATE EXTERNAL TABLE lineitem
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_1/nation';

CREATE EXTERNAL TABLE part
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_1/part';

CREATE EXTERNAL TABLE partsupp
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_1/partsupp';

CREATE EXTERNAL TABLE region
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_1/region';

CREATE EXTERNAL TABLE supplier
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_1/supplier';

CREATE EXTERNAL TABLE nation
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_1/nation';
