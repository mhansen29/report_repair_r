#1-23-25 

just_institution_number <- read_excel("C:/Users/mollyhansen/Desktop/submission just institution number 1-23-25.xlsx", skip = 2) %>% 
  rename(id = 'Institution Number')
original <- read_excel("C:/Users/mollyhansen/Desktop/submission original 1-23-25.xlsx", skip = 2) %>% 
  rename(id = 'Institution Number')
no_increment_budget <- read_excel("C:/Users/mollyhansen/Desktop/submission no requested increment budget period 1-23-25.xlsx", skip = 2) %>% 
  rename(id = 'Institution Number')


just_institution_number_unique <- just_institution_number %>% distinct(id, .keep_all = TRUE) 
original_unique <- original %>% distinct(id, .keep_all = TRUE)
no_increment_budget_unique <- no_increment_budget %>% distinct(id, .keep_all = TRUE) 

NA_original_unique <- original_unique %>% 
  summarise(across(everything(), ~ sum(is.na(.)))) %>% 
  select(!'Requested Increment Budget Period') %>% 
  pivot_longer('Current Proposal Status':'Anticipated Full Award End Date') %>% 
  rename(value_original = value)

NA_no_increment_budget_unique <- no_increment_budget_unique %>% 
  summarise(across(everything(), ~ sum(is.na(.)))) %>% 
  pivot_longer('Current Proposal Status':'Anticipated Full Award End Date') %>% 
  rename(value_no_budget = value)

compare_unique <- left_join(NA_original_unique, NA_no_increment_budget_unique)


NA_original <- original %>% 
  summarise(across(everything(), ~ sum(is.na(.)))) %>% 
  select(!'Requested Increment Budget Period') %>% 
  pivot_longer('Current Proposal Status':'Anticipated Full Award End Date') %>% 
  rename(value_original = value)

NA_no_increment_budget <- no_increment_budget %>% 
  summarise(across(everything(), ~ sum(is.na(.)))) %>% 
  pivot_longer('Current Proposal Status':'Anticipated Full Award End Date') %>% 
  rename(value_no_budget = value)

compare <- left_join(NA_original, NA_no_increment_budget)
compare <- compare %>% mutate(diff = value_no_budget - value_original)
