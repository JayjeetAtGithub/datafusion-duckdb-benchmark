# H2O Dataset Generation

## Installing dependencies

```bash
git clone https://github.com/coiled/h2o-benchmarks
cd h2o-benchmarks/scripts/
python3 -m venv venv
source venv/bin/activate
pip install numpy pandas dask pyarrow pytest pre-commit
```

## Generating GROUP BY dataset

```bash
# for 500MB dataset,
python create_groupby_data.py --num-rows 10000000 --num-groups 100 --num-files 10 --output-dir dataset/

# for 5GB dataset,
python create_groupby_data.py --num-rows 100000000 --num-groups 100 --num-files 100 --output-dir dataset/

# for 50GB dataset,
python create_groupby_data.py --num-rows 1000000000 --num-groups 100 --num-files 1000 --output-dir dataset/

# accumulate the data in the generated files into a single file; for the 5GB dataset example,
python create_single_csv.py \
     --output-file dataset/5GB.csv \
     --input-files-name dataset/groupby-num_rows_100000000-num_groups_100-file \
     --num-files 100
```
