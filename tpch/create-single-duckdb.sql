-- Single parquet file

CREATE VIEW customer AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_dataset/customer/part-0.parquet');

CREATE VIEW orders AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_dataset/orders/part-0.parquet');

CREATE VIEW lineitem AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_dataset/lineitem/part-0.parquet');

CREATE VIEW part AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_dataset/part/part-0.parquet');

CREATE VIEW partsupp AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_dataset/partsupp/part-0.parquet');

CREATE VIEW region AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_dataset/region/part-0.parquet');

CREATE VIEW supplier AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_dataset/supplier/part-0.parquet');

CREATE VIEW nation AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_dataset/nation/part-0.parquet');
