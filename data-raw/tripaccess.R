## code to prepare `tripaccess` dataset goes here

library(tidyverse)
trip <- read_csv("~/DisabilityInclusionAnalyticsLab/data_sources/national_household_travel_survey/trippub.csv")

per <- read_csv("~/DisabilityInclusionAnalyticsLab/data_sources/national_household_travel_survey/perpub.csv")

trip_selected <- trip |>
  dplyr::select(HOUSEID,
                PERSONID,
                TRIPPURP, # Generalized purpose of trip, home-based and non-home based
                GASPRICE, # Price of gasoline, in cents, on respondent's travel day
                NUMONTRP, # Number of people on trip including respondent
                TRPMILES, # Trip distance in miles, derived from route geometry returned
                TRVLCMIN, # Trip Duration in Minutes
                VMT_MILE) |>  # Trip distance in miles for personally driven vehicle trips
  filter(NUMONTRP != -9 & TRPMILES != -9 & TRVLCMIN != -9) |>
  group_by(HOUSEID, PERSONID, TRIPPURP) |>
  dplyr::summarize(Sum_num_of_people = round(sum(NUMONTRP), digits = 0),
                   Sum_trip_distance = round(sum(TRPMILES), digits = 2),
                   Sum_trip_duration = round(sum(TRVLCMIN), digits = 2)) |>
  mutate(TRIPPURP = case_when(TRIPPURP == "HBSHOP" ~ "shopping_trip",
                              TRIPPURP == "HBO" ~ "other_home_based_trip",
                              TRIPPURP == "HBSOCREC" ~ "social_recreational_trip",
                              TRIPPURP == "HBW" ~ "work_trip",
                              TRIPPURP == "NHB" ~ "other_non_home_based_trip")) |>
  filter(TRIPPURP != "-9")

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
                HHSTATE, # State
                WTPERFIN # Final person weight
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
                          EDUC == "05" ~ "Graduate degree or professional degree")) |>
  mutate(BORNINUS = case_when(BORNINUS == "01" ~ "Yes",
                              BORNINUS == "02" ~ "No"))

per_selected_join <- per_selected |>
  inner_join(trip_selected, by = c("HOUSEID" = "HOUSEID", "PERSONID" = "PERSONID")) |>
  filter(if_any(c(Sum_num_of_people:Sum_trip_duration), ~ !is.na(.)))

per_selected_join_rename <- per_selected_join |>
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
         sum_num_of_people_on_trip = Sum_num_of_people,
         sum_trip_distance_in_miles = Sum_trip_distance,
         sum_trip_duration_in_minutes = Sum_trip_duration,
         trip_purpose = TRIPPURP,
         urban_rural = URBRUR,
         state = HHSTATE,
         person_weight = WTPERFIN
  ) |>
  dplyr::select(-MEDCOND)

per_selected_join_wider <- per_selected_join_rename |>
  mutate(trip_purpose_val = 1) |>
  pivot_wider(names_from = trip_purpose,
              values_from = trip_purpose_val)
per_selected_join_wider[is.na(per_selected_join_wider)] <- 0
per_selected_join_final <- per_selected_join_wider |>
  mutate(person_weight = as.character(person_weight)) |>
  group_by(household_id, person_id, travel_disability, sex, race, hispanic_ethnicity, nativity, age, education, self_rated_health, employment_status, household_income, household_structure, population_density, urban_rural, state, driver_status, cane, manual_wheelchair, crutches, dog, motorized_wheelchair, scooter, white_cane, walker, other_accommodation, person_weight) |>
  dplyr::summarize(yearly_miles_personally_driven = sum(yearly_miles_personally_driven),
                   count_of_public_transit_usage = sum(count_of_public_transit_usage),
                   count_of_rideshare_app_usage = sum(count_of_rideshare_app_usage),
                   count_of_bike_trips = sum(count_of_bike_trips),
                   count_of_walk_trips = sum(count_of_walk_trips),
                   count_of_online_delivery = sum(count_of_online_delivery),
                   avg_num_of_people_on_trip = sum(sum_num_of_people_on_trip)/sum(other_home_based_trip+work_trip+social_recreational_trip+other_non_home_based_trip+shopping_trip),
                   avg_trip_distance_in_miles = sum(sum_trip_distance_in_miles)/sum(other_home_based_trip+work_trip+social_recreational_trip+other_non_home_based_trip+shopping_trip),
                   avg_trip_duration_in_minutes = sum(sum_trip_duration_in_minutes)/sum(other_home_based_trip+work_trip+social_recreational_trip+other_non_home_based_trip+shopping_trip),
                   other_home_based_trip = sum(other_home_based_trip),
                   work_trip = sum(work_trip),
                   social_recreational_trip = sum(social_recreational_trip),
                   other_non_home_based_trip = sum(other_non_home_based_trip),
                   shopping_trip = sum(shopping_trip)
  ) |>
  ungroup() |>
  mutate(person_weight = as.numeric(person_weight))
per_selected_join_final <- per_selected_join_final |>
  mutate(across(c(other_home_based_trip:shopping_trip), ~ifelse(.x==1, TRUE, FALSE)))

col_order <- c("household_id", "person_id", "travel_disability", "sex", "race", "hispanic_ethnicity", "nativity", "age", "education", "self_rated_health", "employment_status", "household_income", "household_structure", "population_density", "urban_rural", "state", "driver_status", "cane", "manual_wheelchair", "crutches", "dog", "motorized_wheelchair", "scooter", "white_cane", "walker", "other_accommodation", "yearly_miles_personally_driven", "count_of_public_transit_usage", "count_of_rideshare_app_usage", "count_of_bike_trips", "count_of_walk_trips", "count_of_online_delivery", "avg_num_of_people_on_trip", "avg_trip_distance_in_miles", "avg_trip_duration_in_minutes", "shopping_trip", "social_recreational_trip", "other_home_based_trip", "work_trip", "other_non_home_based_trip", "person_weight")

tripaccess <- per_selected_join_final[, col_order]

save(tripaccess, file = "data/tripaccess.rda", compress = "xz")

usethis::use_data(tripaccess, overwrite = TRUE, compress = "xz")
