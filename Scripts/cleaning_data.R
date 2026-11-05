
# Lab 5: Clean Lab 3 sample data

# Load project-specific R packages
library(stringr)
library(dplyr)

# Get input and output paths from Snakemake
input_file <- snakemake@input[["myfile"]]
output_file <- snakemake@output[[1]]

# Read messy data
messy_data <- read.csv(input_file, stringsAsFactors = FALSE)

# ==========================
# Sample ID Standardization

sample_id_clean <- str_to_upper(messy_data$sample_id)
sample_id_clean <- str_remove(sample_id_clean, "-")
messy_data$sample_id <- sample_id_clean


# ==========================
# Date of Birth Standardization

messy_data$dob <- case_when(
  str_detect(messy_data$dob, "/") ~
    format(as.Date(messy_data$dob, "%m/%d/%Y"), "%Y/%m/%d"),
  
  str_detect(messy_data$dob, "\\.") ~
    format(as.Date(messy_data$dob, "%m.%d.%y"), "%Y/%m/%d"),
  
  str_detect(messy_data$dob, "^\\d{4}-") ~
    format(as.Date(messy_data$dob, "%Y-%m-%d"), "%Y/%m/%d"),
  
  TRUE ~
    format(as.Date(messy_data$dob, "%d-%b-%Y"), "%Y/%m/%d")
)


# ==========================
# Sex Standardization

sex_clean <- str_to_lower(messy_data$sex)

sex_clean <- case_when(
  sex_clean == "male" ~ "M",
  sex_clean == "m" ~ "M",
  sex_clean == "female" ~ "F",
  sex_clean == "f" ~ "F",
  sex_clean == "unknown" ~ "NA",
  sex_clean == "u" ~ "NA",
  TRUE ~ "NA"
)

messy_data$sex <- sex_clean


# ==========================
# Enrollment Site Standardization

site_clean <- str_to_lower(messy_data$enrollment_site)
site_clean <- str_extract(site_clean, "[abc]")
site_clean <- str_to_upper(site_clean)

messy_data$enrollment_site <- site_clean


# ==========================
# Glucose Value & Unit Standardization

unit_clean <- str_to_lower(messy_data$glucose_unit)

unit_clean <- case_when(
  str_detect(unit_clean, "mmol") ~ "mg/dl",
  TRUE ~ unit_clean
)

messy_data$glucose_unit <- unit_clean


# ==========================
# Save Cleaned Data

clean_data <- messy_data

write.csv(clean_data, output_file, row.names = FALSE)

cat("Cleaned sample data saved to:", output_file, "\n")
