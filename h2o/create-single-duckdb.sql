CREATE VIEW h2o_group AS SELECT * FROM read_csv_auto('G1_1e7_1e2_5_0.csv');
CREATE VIEW h2o_join AS SELECT * FROM read_csv_auto('J1_1e7_NA_0_0.csv.gz');
CREATE VIEW h2o_join_small AS SELECT * FROM read_csv_auto('J1_1e7_1e1_0_0.csv.gz');
CREATE VIEW h2o_join_medium AS SELECT * FROM read_csv_auto('J1_1e7_1e4_0_0.csv.gz');
CREATE VIEW h2o_join_big AS SELECT * FROM read_csv_auto('J1_1e7_1e7_0_0.csv.gz');