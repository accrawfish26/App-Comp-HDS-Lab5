<<<<<<< HEAD
\# Lab 5



\## Set-up

1. Clone the repro

2\. Use the `environment.yml` file to install necessary packages
```

conda activate
conda env -f environment.yml


```

3\. Test that snakemake runs with `snakemake -n`. The expected results for job status:



```

Job stats:

job                      count

\---------------------  -------

clean\_patient\_table          1

create\_feature\_table         1

merge\_analytic\_tables        1

all                          1

total                        4



```

\## Snakemake Opperations

Within the `snakefile` there are 4 set rules.



\### Rule 1

The primary purpose was reusing lab 3 script to clean the `Data/messy\_samples.csv`. The script that performed this was `Scripts/cleaning\_data.R`. The packages required were saved within the `environment.yml` to help with reproducibility.



\### Rule 2

The primary purpose was reusing lab 4 script to create a feature table from the `Data/cohort.db`. The script that performed this was `Scripts/feature\_table.py`. The packages required were saved within the `environment.yml` to help with reproducibility.



\### Messy Data File





=======
# Lab 5

## Expectations

Lab 5 converts a "loose collection of scripts" into one manageable workflow based on materials developed during labs 3 & 4 (scripts that interacted with week 3 data: `lab3-messy-data` & lab 4 data: `cohort.db`). 

1. Define the pipeline as DAG using **Snakemake** with these stages
2. Clean `messy_samples.csv` that reused the script and output from Lab 3
3. Query `cohort.db` for a features table, reusing the script and output from Lab 4
4. Merge `clean_samples.csv` with `features_table.tsv` as one combined analytic table
5. Produce a summary report as a notebook/simple figure + text using the combined table

Within Snakemake, declare all real inputs & outputs for each rule/process, so no steps silently depend on a file.

Have the ability to re-run the full pipeline from a clean state & change one upstream input and show how it affects downstream steps when re-running. **Include screenshot** and/or paste the console output. 

Document any use of AI during the process, including the writing of workflow rules


## Set Up
>>>>>>> orign/main
