#!/bin/bash

# Runs single core performance of all three benchmarks

echo "****** H2O ******"
(cd h2o && bash benchmark.sh)
(cd h2o && python3 plot.py comparison)

echo "****** TPCH ******"
(cd tpch && bash benchmark.sh)
(cd tpch && python3 plot.py comparison)

echo "****** Clickbench ******"
(cd clickbench && bash benchmark.sh comparison)
(cd clickbench && python3 plot.py comparison)

# Compute summary information
(cd results && python3 summary.py)
