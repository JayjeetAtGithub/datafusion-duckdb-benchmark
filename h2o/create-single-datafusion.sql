CREATE EXTERNAL TABLE h2o (
    id1  VARCHAR,
    id2  VARCHAR,
    id3  VARCHAR,
    id4  INT,
    id5  INT,
    id6  INT,
    v1  INT,
    v2 INT,
    v3 DOUBLE
)
STORED AS CSV
WITH HEADER ROW
LOCATION 'G1_1e7_1e2_5_0.csv';