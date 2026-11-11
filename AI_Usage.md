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


**My Edits & My Validation of Code:**
I ran with `--use-conda` and had success. This was also a turning point in learning about how `environment.yml` can be used instead, and it's a lot easier, to provide packages and dependencies for the `snakemake --cores` function to run through. 

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
