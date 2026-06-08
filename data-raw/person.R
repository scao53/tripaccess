## code to prepare `person` dataset goes here

library(tidyverse)
nhts_data_dir <- Sys.getenv(
  "NHTS_2017_DATA_DIR",
  unset = "../di_pedagogy/original datasets"
)

per <- read_csv(file.path(nhts_data_dir, "perpub.csv"))

per_selected <- per |>
  dplyr::select(HOUSEID, # Household ID
                PERSONID, # Person ID
                MEDCOND, # Medical condition
                MEDCOND6, # Medical condition, how long
                R_SEX_IMP, # Gender (imputed)
                R_AGE_IMP, # Age (imputed)
                R_RACE, # Race
                R_HISP, # Hispanic or not
                BORNINUS, # Born in United States
                PRMACT, # Primary activity in previous week
                HEALTH, # Opinion of health
                HHFAMINC, # Household income
                HBPPOPDN, # Category of population density (persons per square mile) in the census block group of the household's home location
                HHSIZE, # Count of household members
                NBIKETRP, # Count of bike trips
                NWALKTRP, # Count of walk trips
                RIDESHARE, # Count of rideshare app usage
                DRIVER, # Driver status, derived
                W_CANE, # Medical device used: Cane
                W_CHAIR, # Medical device used: Wheelchair
                W_CRUTCH, # Medical device used: Crutches
                W_DOG, # Medical device used: Dog assistance
                W_MTRCHR, # Medical device used: Motorized wheelchair
                W_SCOOTR, # Medical device used: Motorized scooter
                W_WHCANE, # Medical device used: White cane
                W_WLKR, # Medical device used: Walker
                W_NONE, # Medical device used: None
                YEARMILE, # Miles personally driven in all vehicles
                PTUSED, # Count of public transit usage
                DELIVER, # Count of times purchased online for delivery in last 30 days
                URBRUR, # Household in urban/rural area
                EDUC, # Educational attainment
                HHSTATE # State
  ) |>
  filter(YEARMILE >= -1) |> # filter to YEARMILE >= -1
  filter(PTUSED >= 0) |>
  filter(DELIVER >= -1) |>
  filter(NBIKETRP >= 0) |>
  filter(NWALKTRP >= 0) |>
  filter(RIDESHARE >= -1) |>
  filter(MEDCOND == "01" | MEDCOND == "02") |> # filter to Medical condition Yes "01" and No "02"
  filter(MEDCOND6 == "01" | MEDCOND6 == "02" | MEDCOND6 == "03" | MEDCOND6 == "-1") |> # filter to Medical condition duration 6_months_or_less "01", More_than_6_months "02", Lifelong "03", and No_disability "-1"
  filter(R_AGE_IMP >= 18 & R_AGE_IMP <= 61) |>
  filter(R_RACE != "-8" & R_RACE != "-7") |>
  filter(R_HISP != "-8" & R_HISP != "-7") |>
  filter(BORNINUS != "-9" & BORNINUS != "-8" & BORNINUS != "-7") |>
  filter(PRMACT != "-8" & PRMACT != "-7" & PRMACT != "-1") |>
  filter(HEALTH != "-9" & HEALTH != "-8" & HEALTH != "-7") |>
  filter(HHFAMINC != "-9" & HHFAMINC != "-8" & HHFAMINC != "-7") |>
  filter(HBPPOPDN != -9) |>
  filter(DRIVER != "-1") |>
  filter(EDUC != "-8" & EDUC != "-7") |>
  mutate(W_CANE = case_when(W_CANE == "01" ~ "True",
                            TRUE ~ "False")) |>
  mutate(W_CHAIR = case_when(W_CHAIR == "07" ~ "True",
                             TRUE ~ "False")) |>
  mutate(W_CRUTCH = case_when(W_CRUTCH == "05" ~ "True",
                              TRUE ~ "False")) |>
  mutate(W_DOG = case_when(W_DOG == 4 ~ "True",
                           TRUE ~ "False")) |>
  mutate(W_MTRCHR = case_when(W_MTRCHR == "08" ~ "True",
                              TRUE ~ "False")) |>
  mutate(W_SCOOTR = case_when(W_SCOOTR == "06" ~ "True",
                              TRUE ~ "False")) |>
  mutate(W_WHCANE = case_when(W_WHCANE == "03" ~ "True",
                              TRUE ~ "False")) |>
  mutate(W_WLKR = case_when(W_WLKR == "02" ~ "True",
                            TRUE ~ "False")) |>
  mutate(W_NONE = case_when(W_NONE == 0 ~ "True",
                            TRUE ~ "False")) |>
  mutate(MEDCOND6 = case_when(MEDCOND6 == "01" ~ "6_months_or_less_disability",
                              MEDCOND6 == "02" ~ "More_than_6_months_of_disability",
                              MEDCOND6 == "03" ~ "Lifelong_disability",
                              TRUE ~ "No_disability")) |>
  mutate(R_SEX_IMP = case_when(R_SEX_IMP == "01" ~ "Male",
                               R_SEX_IMP == "02" ~ "Female")) |>
  mutate(R_RACE = case_when(R_RACE == "01" ~ "White",
                            R_RACE == "02" ~ "Black",
                            R_RACE == "03" ~ "Asian",
                            R_RACE == "04" ~ "American Indian",
                            R_RACE == "05" ~ "Hawaiian/Pacific Islander",
                            R_RACE == "06" ~ "Multiracial",
                            TRUE ~ "Other")) |>
  mutate(R_HISP = case_when(R_HISP == "01" ~ "Hispanic",
                            R_HISP == "02" ~ "Non-Hispanic")) |>
  mutate(PRMACT = case_when(PRMACT %in% c("01", "02") ~ "Employed",
                            TRUE ~ "Unemployed")) |>
  mutate(HEALTH = case_when(HEALTH == "01" ~ "Excellent",
                            HEALTH == "02" ~ "Very good",
                            HEALTH == "03" ~ "Good",
                            HEALTH == "04" ~ "Fair",
                            HEALTH == "05" ~ "Poor")) |>
  mutate(HHFAMINC = case_when(HHFAMINC == "01" ~ "Under $10,000",
                              HHFAMINC %in% c("02", "03", "04") ~ "$10,000 to $34,999",
                              HHFAMINC %in% c("05", "06") ~ "$35,000 to $74,999",
                              HHFAMINC %in% c("07", "08", "09") ~ "$75,000 to $149,999",
                              HHFAMINC %in% c("10", "11") ~ "$150,000 and over")) |>
  mutate(HBPPOPDN = case_when(HBPPOPDN == 50 ~ "0-99",
                              HBPPOPDN == 300 ~ "100-499",
                              HBPPOPDN == 750 ~ "500-999",
                              HBPPOPDN == 1500 ~ "1,000-1,999",
                              HBPPOPDN == 3000 ~ "2,000-3,999",
                              HBPPOPDN == 7000 ~ "4,000-9,999",
                              HBPPOPDN == 17000 ~ "10,000-24,999",
                              HBPPOPDN == 30000 ~ "25,000 and over")) |>
  mutate(DRIVER = case_when(DRIVER == "01" ~ "Drives",
                            TRUE ~ "Does not drive")) |>
  mutate(HHSIZE = case_when(HHSIZE == 1 ~ "Lives alone",
                            TRUE ~ "Does not live alone")) |>
  mutate(YEARMILE = case_when(YEARMILE == -1 ~ 0,
                              TRUE ~ YEARMILE)) |>
  mutate(DELIVER = case_when(DELIVER == -1 ~ 0,
                             TRUE ~ DELIVER)) |>
  mutate(RIDESHARE = case_when(RIDESHARE == -1 ~ 0,
                               TRUE ~ RIDESHARE)) |>
  mutate(URBRUR = case_when(URBRUR == "01" ~ "Urban",
                            TRUE ~ "Rural")) |>
  mutate(EDUC = case_when(EDUC == "01" ~ "Less than a high school graduate",
                          EDUC == "02" ~ "High school graduate or GED",
                          EDUC == "03" ~ "Some college or associates degree",
                          EDUC == "04" ~ "Bachelor's degree",
                          EDUC == "05" ~ "Graduate degree or professional degree"))

per_selected_rename <- per_selected |>
  rename(household_id = HOUSEID,
         person_id = PERSONID,
         travel_disability = MEDCOND6,
         sex = R_SEX_IMP,
         race = R_RACE,
         hispanic_ethnicity = R_HISP,
         nativity = BORNINUS,
         age = R_AGE_IMP,
         education = EDUC,
         employment_status = PRMACT,
         self_rated_health = HEALTH,
         household_income = HHFAMINC,
         household_structure = HHSIZE,
         population_density = HBPPOPDN,
         driver_status = DRIVER,
         yearly_miles_personally_driven = YEARMILE, # Miles personally driven in all vehicles
         count_of_public_transit_usage = PTUSED, # Count of public transit usage
         count_of_rideshare_app_usage = RIDESHARE,
         count_of_bike_trips = NBIKETRP,
         count_of_walk_trips = NWALKTRP,
         cane = W_CANE, # Medical device used: Cane
         manual_wheelchair = W_CHAIR, # Medical device used: Wheelchair
         crutches = W_CRUTCH, # Medical device used: Crutches
         dog = W_DOG, # Medical device used: Dog assistance
         motorized_wheelchair = W_MTRCHR, # Medical device used: Motorized wheelchair
         scooter = W_SCOOTR, # Medical device used: Motorized scooter
         white_cane = W_WHCANE, # Medical device used: White cane
         walker = W_WLKR, # Medical device used: Walker
         other_accommodation = W_NONE, # Medical device used: None
         count_of_online_delivery = DELIVER, # Count of times purchased online for delivery in last 30 days
         urban_rural = URBRUR,
         state = HHSTATE
  ) |>
  dplyr::select(-MEDCOND)

col_order <- c("household_id", "person_id", "travel_disability", "sex", "race", "hispanic_ethnicity", "nativity", "age", "education", "self_rated_health", "employment_status", "household_income", "household_structure", "population_density", "urban_rural", "state", "driver_status", "cane", "manual_wheelchair", "crutches", "dog", "motorized_wheelchair", "scooter", "white_cane", "walker", "other_accommodation", "yearly_miles_personally_driven", "count_of_public_transit_usage", "count_of_rideshare_app_usage", "count_of_bike_trips", "count_of_walk_trips", "count_of_online_delivery")

person <- per_selected_rename[, col_order]

save(person, file = "data/person.rda", compress = "xz")

usethis::use_data(person, overwrite = TRUE, compress = "xz")
