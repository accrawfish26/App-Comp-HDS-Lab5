# Lab 5 Scalable Analysis Workflow

## Set-up

1. Clone the repro

``` 
git clone https://github.com/accrawfish26/App-Comp-HDS-Lab4.git
```
2. Set the working directory to the repository root
3. Activate Conda to open the `environment.yml` file to install necessary packages

```
conda activate
conda env -f environment.yml

```
3. Test that snakemake runs with `snakemake -n`. The expected results for job status:

```
Job stats:

job                      count
---------------------  -------
clean\_patient\_table          1

create\_feature\_table         1

merge\_analytic\_tables        1

all                          1

total                        4
```

## Snakemake Opperations

Within the `snakefile` there are 4 set rules.

### Rule 1

The primary purpose was reusing lab 3 script to clean the `Data/messy\_samples.csv`. The script that performed this was `Scripts/cleaning\_data.R`. The packages required were saved within the `environment.yml` to help with reproducibility.

### Rule 2

The primary purpose was reusing lab 4 script to create a feature table from the `Data/cohort.db`. The script that performed this was `Scripts/feature\_table.py`. The packages required were saved within the `environment.yml` to help with reproducibility.
