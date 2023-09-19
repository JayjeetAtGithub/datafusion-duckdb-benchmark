-- Single parquet file

CREATE EXTERNAL TABLE customer
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_sf1/customer/part-0.parquet';

CREATE EXTERNAL TABLE orders
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_sf1/orders/part-0.parquet';

CREATE EXTERNAL TABLE lineitem
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_sf1/nation/part-0.parquet';

CREATE EXTERNAL TABLE part
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_sf1/part/part-0.parquet';

CREATE EXTERNAL TABLE partsupp
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_sf1/partsupp/part-0.parquet';

CREATE EXTERNAL TABLE region
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_sf1/region/part-0.parquet';

CREATE EXTERNAL TABLE supplier
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_sf1/supplier/part-0.parquet';

CREATE EXTERNAL TABLE nation
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_sf1/nation/part-0.parquet';
