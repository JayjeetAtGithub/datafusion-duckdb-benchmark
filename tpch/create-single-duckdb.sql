-- Single parquet file

CREATE VIEW customer AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_sf1/customer/part-0.parquet');

CREATE VIEW orders AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_sf1/orders/part-0.parquet');

CREATE VIEW lineitem AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_sf1/lineitem/part-0.parquet');

CREATE VIEW part AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_sf1/part/part-0.parquet');

CREATE VIEW partsupp AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_sf1/partsupp/part-0.parquet');

CREATE VIEW region AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_sf1/region/part-0.parquet');

CREATE VIEW supplier AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_sf1/supplier/part-0.parquet');

CREATE VIEW nation AS
SELECT * FROM read_parquet('../arrow-datafusion/benchmarks/data/tpch_sf1/nation/part-0.parquet');
