-- Single parquet file

CREATE EXTERNAL TABLE customer
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_dataset/customer/part-0.parquet';

CREATE EXTERNAL TABLE orders
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_dataset/orders/part-0.parquet';

CREATE EXTERNAL TABLE lineitem
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_dataset/lineitem/part-0.parquet';

CREATE EXTERNAL TABLE part
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_dataset/part/part-0.parquet';

CREATE EXTERNAL TABLE partsupp
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_dataset/partsupp/part-0.parquet';

CREATE EXTERNAL TABLE region
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_dataset/region/part-0.parquet';

CREATE EXTERNAL TABLE supplier
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_dataset/supplier/part-0.parquet';

CREATE EXTERNAL TABLE nation
STORED AS PARQUET
LOCATION '../arrow-datafusion/benchmarks/data/tpch_dataset/nation/part-0.parquet';
