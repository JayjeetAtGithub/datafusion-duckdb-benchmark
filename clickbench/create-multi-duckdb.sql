CREATE VIEW hits AS
SELECT *
	REPLACE
	(epoch_ms(EventTime * 1000) AS EventTime,
	 DATE '1970-01-01' + INTERVAL (EventDate) DAYS AS EventDate)
FROM read_parquet('hits_multi/hits_*.parquet', binary_as_string=True);
