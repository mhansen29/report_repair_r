##relevant packages, un-comment if needed(delete preceding #, or ctrl+shift+c selected text)
install.packages("tidyverse")
install.packages("janitor")
install.packages("writexl")

library(tidyverse)
library(readxl)
library(janitor)
library(writexl)

#UPDATE HERE WITH WHATEVER FILE NAMES YOU NEED TO RUN
submission_import_filename <- "submissions_2025_01_f180_import_2.xlsx"
award_import_filename <- "awards_2025_01_f180_import_2.xlsx"
recorded_date_filename <- "recorded_date_2025_01_f180_import_2.xlsx"

#UPDATE HERE WITH EXPORT FILE TITLES
submission_export_filename <- "submission_2025_01_2.xlsx" #updated_submissions_2024_12_f180_export"
award_export_filename <- "award_2025_01_2.xlsx" #updated_awards_2024_12_f180_export.xlsx"


#DONT CHANGE ANYTHING DOWN HERE
#set import filepaths 
submission_import_filepath <- file.path("..", "import_files_from_infoed", "f180", submission_import_filename)
award_import_filepath <- file.path("..", "import_files_from_infoed", "f180", award_import_filename)
recorded_date_filepath <- file.path("..", "import_files_from_infoed", "f180", recorded_date_filename)

#import files and standardize date in recorded_date
submission_import <- read_excel(submission_import_filepath, sheet = "Sheet1", skip = 2)
award_import <- read_excel(award_import_filepath, sheet = "Sheet1", skip = 2)
recorded_date <- read_excel(recorded_date_filepath, skip = 2)  
recorded_date$`Current Proposal Status Date - Recorded Date` <- date(recorded_date$`Current Proposal Status Date - Recorded Date`)

#fix for 1/15/25 error
award_import$`Institution Number` <- as.character(award_import$`Institution Number`)
award_import$`Institution Number` <- award_import$`Institution Number` %>% replace_na('9690.M')

#join submission and dates, moving/renaming date column to match expected report format
submission_join <- left_join(submission_import, recorded_date, by = "Institution Number") %>% 
  relocate('Current Proposal Status Date - Recorded Date', .before = 'Current Proposal Status') %>% 
  rename('Current Proposal Status Date' = 'Current Proposal Status Date - Recorded Date')

#join awards and dates, moving/renaming date column to match expected report format
award_join <- left_join(award_import, recorded_date, by = "Institution Number") %>% 
  relocate('Current Proposal Status Date - Recorded Date', .before = 'Current Proposal Status') %>% 
  rename('Current Proposal Status Date' = 'Current Proposal Status Date - Recorded Date')  

#set export filepaths
submission_export_filepath <- file.path("..", "export_files_for_distribution", submission_export_filename)
award_export_filepath <- file.path("..", "export_files_for_distribution", award_export_filename)

#write new export files
write_xlsx(x = submission_join, path = submission_export_filepath, col_names = TRUE)
write_xlsx(x = award_join, path = award_export_filepath, col_names = TRUE)


#1-17-25 K Campbell issue
distinct_submissions <- submission_import %>% select('Institution Number') %>% rename(id = 'Institution Number') %>% distinct()










