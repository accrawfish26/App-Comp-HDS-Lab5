# AI Transparancy

## Prompt 1

**Model:** ChatGPT
**Error Message:**
```
snakemake: error: unrecognized arguments: --software-deployment-method
```
**ChatGPT Response:** 
"Your installed Snakemake version does not recognize --software-deployment-method. Since you are using Snakemake 9, try running the workflow with: `snakemake --cores 1 --use-conda`. The `--use-conda` option tells Snakemake to use Conda environments specified by your workflow rules. Also, make sure your Conda installation is configured to use strict channel priorities."

**ChatGPT Suggested Fit:**
Provide the current versions of Snakemake and Conda you are using, and share the code that came before the error message. Most likely, use `--use-conda` instead to run with packages needed for files.

**Agent:** GitHub Copilot
**Agent Validation:**
```{bash}
 --software-deployment-method  is valid in Snakemake 9.23.1. If it is unrecognized, the command being executed is likely not the Snakemake installation from your  lab5  environment.

Check the active executable:

conda activate lab5

which snakemake
type -a snakemake
snakemake --version
python -m snakemake --version

Run the workflow explicitly through the active Python environment:

python -m snakemake --cores 1 --sdm conda

 --sdm conda  is the short form of:

--software-deployment-method conda

For reproducibility, pin Snakemake in  environment.yml :

name: lab5
channels:
  - conda-forge
  - bioconda
  - defaults
dependencies:
  - python=3.12
  - snakemake=9.23.1
  - conda

Then recreate the environment if necessary:

conda env update -n lab5 -f environment.yml --prune
conda activate lab5
python -m snakemake --version

Your  Snakefile  should specify per-rule environments, for example:

rule example:
    input:
        "input.txt"
    output:
        "output.txt"
    conda:
        "envs/example.yaml"
    shell:
        "some_program {input} > {output}"

Then run with:

python -m snakemake --cores 1 --sdm conda
```

**Agent Suggestion:**
"If the workflow does not use any  conda:  directives in its rules, the  --sdm conda  option is unnecessary. For exact cross-computer reproducibility, consider committing a  conda-lock  lockfile in addition to  environment.yml."

**My Edits & My Validation of Code:**
I ran with `--use-conda` and had success. This was also a turning point in learning about how `environment.yml` can be used instead, and it's a lot easier, to provide packages and dependencies for the `snakemake --cores` function to run through. With the AI agent, it provided a roundabout that chatGPT had not done with teaching of `--sdm conda` option with a lockfile. But seems to be in agreement about the command attempted is not compatable to what I wanted to do. 

==============================================
## Prompt 2

**Model:** ChatGPT
**Error Message:**
```
MissingInputException:
Missing input files for rule clean_patient_table:
Data/messy_data.csv
```
**ChatGPT Response:** 
"Snakemake is looking for Data/messy_data.csv, but it cannot find the file at that location. Check that the file exists in the Data directory and that the capitalization and filename match exactly. You should also verify that you are running Snakemake from the Lab 5 project directory."

**ChatGPT Suggested Fit:**
Check that the file within the Snakefile matches the actual folder/file name. Make changes to either based on which is preferred.

**My Edits:**
I looked and saw that `Data/messy_data.csv` was a match. But its point about running Snakemake from the Lab 5 project was important, and I had forgotten to readjust my directory in my terminal. Once moved, it worked. It also helped me learn how to read an error produced by Snakemake later, catching spelling differences between folders.

==============================================
## Prompt 3

**Model:** ChatGPT
**Error Message:**
```
FileNotFoundError:
No such file or directory:
.snakemake/scripts/tmp...feature_table.py
```
**ChatGPT Response:**
"This error appears to involve a temporary script created by Snakemake, rather than your original Python script or SQLite database. Check whether another Snakemake process is still running. If no process is running, inspect the .snakemake/scripts/ directory and clear stale temporary files if necessary. If the workflow directory remains locked, use: `snakemake --unlock`. Then return the workflow."

**ChatGPT Suggested Fit:**
Find the `.snakemake` folder and look into the scripts. If there is data loading in there, it will impact how the current Snakemake runs and may be worth removing.

**My Edits:**
I removed these folders after some time of digging around. This led to success in resolving the error once that was gone. 

==============================================
## Prompt 4

**Model:** ChatGPT
**Error Message:**
```
TypeError:
Could not convert string to numeric
```
**ChatGPT Response:**
"The glucose_value column is still being treated as text (object). The values also contain asterisks (*), which need to be removed before calculating the mean. Run: 
`data["glucose_value"] = pd.to_numeric(data["glucose_value"].astype(str).str.replace("*", "", regex=False), errors="coerce")` then check the column type: `print(data["glucose_value"].dtype)`. You should see `float64`. Once the column is numeric, you can calculate the average glucose value by sex using: `glucose_by_sex = data.groupby("sex")["glucose_value"].mean()`. 

**ChatGPT Suggested Fit:**
It recognized that my code for producing some descriptive statistics is not working correctly due to a data type error. Suggested a way to change an object to a float644 that will act as numeric data that allows for running `.mean` and others.

**My Edits:**
I used this to support my notebook process for preparing data for the summary analysis. I not only changed out the glucose_value, but also some other columns labeled as objects into numeric to help with some simple analysis. The error was resolved when I implemented the `pd.to_numeric` idea into the data preparation.

==============================================
## Additional Prompt with AI Agent: GitHub Copilot on merging tables
**AI Agent:** GitHub Copilot

**Task:** Merge the two given data tables that are not related (see what happens, and if match what I had actually had done).

**Prompt:** Here were my cleaned data output files: Look at the cleaned_data and feature_table and
share your approach these tables to create a simple description on the new joined
table.

**Output:**
```{Bash}
I inspected the files. The important issue is that they do not currently share a valid join key:

•  clean_data.csv : 60 records with synthetic IDs such as  S0001 ,  S0002 , and glucose measurements.
•  feature_table.tsv : 566 patient records with TCGA IDs such as  TCGA-05-4244 .
•  cohort.db : 566 patients and 566 samples, linked by  patient_id ; sample IDs look like  TCGA-05-4244-01 .

Therefore, I would not join them by row order, names, sex, or date of birth. A valid join requires a crosswalk mapping each  S####  identifier to a TCGA patient or sample ID. Without that mapping, the joined values could be incorrect.

Once a crosswalk exists, the approach would be:

CREATE TABLE joined_table AS
SELECT
    c.sample_id AS cleaned_sample_id,
    c.patient_name,
    c.dob,
    c.sex AS cleaned_sex,
    c.enrollment_site,
    c.glucose_value,
    c.glucose_unit,
    f.patient_id,
    f.age_at_diagnosis,
    f.stage,
    f.tissue_source_site,
    f.tmb_nonsynonymous,
    f.EGFR,
    f.KEAP1,
    f.KRAS,
    f.STK11,
    f.TP53
FROM clean_data AS c
LEFT JOIN crosswalk AS x
    ON c.sample_id = x.cleaned_sample_id
LEFT JOIN feature_table AS f
    ON x.patient_id = f.patient_id;

Simple description of the intended joined table:  

The joined table combines cleaned participant-level glucose and enrollment information with cohort-level clinical and molecular features. Each row represents one matched participant, identified through a validated crosswalk. Records without a confirmed match remain in the table with missing cohort features, allowing unmatched records to be quantified ratherj than silently discarded.

Before using it, check that the crosswalk IDs are unique, count unmatched records, and verify that sex and other shared fields agree after joining.
```

**Validation:** The AI had sucessfully noticed that both tables do not currently share a valid join key. It provided an example of patient ID missmatch & not join by row order, names, sex, or date of birth. A different approch it took than I done for lab5 was to create a crosswalk map and shared related code. It emphasised that no patient was silently discarded. When I had seen the code, I had apated the names of variables to fit what I had wrote and it ran correctly without dropping patients. But it is an exact copy of what I had done where it joins, and fill missing data with floats/NA to signify the patient does not have the relevant data. 
