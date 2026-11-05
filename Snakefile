# Snakefile for bringing data together as an analytic table

rule all:
    input:
        "Results/clean_data.csv",
        "Results/feature_table.tsv",
        "Results/analytic_table.csv"

# Creating the patient table that clean from the messy patient file
rule clean_patient_table:
    input:
        myfile = "Data/messy_data.csv"
    output:
        "Results/clean_data.csv"
    script:
        "Scripts/cleaning_data.R"   

# Creating the feature table from the cohort database
rule create_feature_table:
    input:
        db = "Data/cohort.db"
    output:
        "Results/feature_table.tsv"
    script:
        "Scripts/feature_table.py"

# Creating the analytic table to merge data 
rule merge_analytic_tables:
    input:
        lab3_data = "Results/clean_data.csv",
        lab4_data = "Results/feature_table.tsv"
    output:
        "Results/analytic_table.csv"
    script:
        "Scripts/analytic_table.py"