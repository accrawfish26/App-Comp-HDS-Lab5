# Lab 5 Scalable Analysis Workflow
The purpose of this lab is to use Snakemake to integrate multiple components into a single workflow. In this case, the patient data from Labs 3 and 4 were used, and we learned how to put them together to support analysis. 

## Set-up

1. Clone the repo

``` 
git clone https://github.com/accrawfish26/App-Comp-HDS-Lab4.git
```
2. Set the working directory to the repository root
3. Activate Conda to open the `environment.yml` file to install necessary packages to set space as conda lab5.

```
conda env -f environment.yml
conda activate lab5

```
3. Test that snakemake runs with `snakemake -n`. The expected results for job status:

```
Job stats:

job                      count
---------------------  -------
clean_patient_table          1
create_feature_table         1
merge_analytic_tables        1
all                          1

total                        4
```

## Snakemake Opperations

Within the `snakefile` there are 4 set rules.

### Rule 1

The primary purpose was reusing lab 3 script to clean the `Data/messy_samples.csv`. The script that performed this was `Scripts/cleaning_data.R`. The packages required were saved within the `environment.yml` to help with reproducibility.

### Rule 2

The primary purpose was reusing lab 4 script to create a feature table from the `Data/cohort.db`. The script that performed this was `Scripts/feature_table.py`. The packages required were saved within the `environment.yml` to help with reproducibility.

## Rule 3

The primary purpose was obtaining rule 2 & 3 data to merge together as the analytic table found in `Results/analytic_table.csv`. The script that performed this was `Scripts/analytic_table.py`. Something worth noting that rule 2 & 3 sourced from data that are not related to eachother, in terms of being different people/patients. As a result, the merge kept each respective entry, where patients were merged together and kept related metadata per patient. The cells marked as 'NA' suggest they had no data as they had not obtained data from the respective source dataset. 

## Other Folders & Notes

### Scripts/Notebook
Contains a notebook that runs some basic analysis on the table created through snakemake. This can be accessed by:
```
conda activate lab5
cd Scripts
jupyter lab
```
This includes a description of the metadata included in the table, performs descriptive analysis on certain variables, and produces visualizations of those trends. This led to creating a **summary report that can be found at the bottom of the `Scripts/Analytic_Summary_Report.ipynb`**

### Logs
This notes a successful run of the snakemake, and when reproduced, should aim for something similar. 

### AI_Usage
This outlines how the AI model (ChatGPT) helped me work through various errors at different points in this lab project. It was not used when making my own interpretations/writing in my own words.  
