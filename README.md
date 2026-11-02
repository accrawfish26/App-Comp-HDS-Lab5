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
