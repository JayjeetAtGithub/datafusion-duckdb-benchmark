#!/bin/bash

# Runs all three benchmarks



echo "****** H2O ******"
(cd h2o && bash benchmark.sh)
(cd h2o && python3 plot.py)

echo "****** TPCH ******"
(cd tpch && bash benchmark.sh)
(cd tpch && python3 plot.py)

echo "****** Clickbench ******"
(cd clickbench && bash benchmark.sh multi)
(cd clickbench && python3 plot.py comparison)
(cd clickbench && python3 plot.py scalability)
