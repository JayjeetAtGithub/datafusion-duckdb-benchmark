CREATE VIEW x_group AS SELECT * FROM read_csv_auto('G1_1e7_1e2_5_0.csv');
CREATE VIEW x AS SELECT * FROM read_csv_auto('J1_1e7_NA_0_0.csv');
CREATE VIEW small AS SELECT * FROM read_csv_auto('J1_1e7_1e1_0_0.csv');
CREATE VIEW medium AS SELECT * FROM read_csv_auto('J1_1e7_1e4_0_0.csv');
CREATE VIEW big AS SELECT * FROM read_csv_auto('J1_1e7_1e7_0_0.csv');