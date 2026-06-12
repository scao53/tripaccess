## code to prepare `trip` dataset goes here

library(tidyverse)
nhts_data_dir <- Sys.getenv(
  "NHTS_2017_DATA_DIR",
  unset = "../di_pedagogy/original datasets"
)

trip_org <- read_csv(file.path(nhts_data_dir, "trippub.csv"))

trip_selected <- trip_org |>
  dplyr::select(HOUSEID,
                PERSONID,
                TRIPPURP, # Generalized purpose of trip, home-based and non-home based
                GASPRICE, # Price of gasoline, in cents, on respondent's travel day
                NUMONTRP, # Number of people on trip including respondent
                TRPMILES, # Trip distance in miles, derived from route geometry returned
                TRVLCMIN, # Trip Duration in Minutes
                VMT_MILE) |>  # Trip distance in miles for personally driven vehicle trips
  filter(NUMONTRP != -9 & TRPMILES != -9 & TRVLCMIN != -9) |>
  mutate(TRIPPURP = case_when(TRIPPURP == "HBSHOP" ~ "shopping_trip",
                              TRIPPURP == "HBO" ~ "other_home_based_trip",
                              TRIPPURP == "HBSOCREC" ~ "social_recreational_trip",
                              TRIPPURP == "HBW" ~ "work_trip",
                              TRIPPURP == "NHB" ~ "other_non_home_based_trip")) |>
  filter(TRIPPURP != "-9")

trip_selected_rename <- trip_selected |>
  rename(household_id = HOUSEID,
         person_id = PERSONID,
         trip_purpose = TRIPPURP,
         gas_price = GASPRICE,
         num_of_people_on_trip = NUMONTRP,
         trip_miles = TRPMILES,
         trip_duration = TRVLCMIN,
         trip_miles_personally_driven_vehicle = VMT_MILE
  )

col_order <- c("household_id", "person_id", "trip_purpose", "gas_price", "num_of_people_on_trip", "trip_miles", "trip_duration", "trip_miles_personally_driven_vehicle")

trip <- trip_selected_rename[, col_order]

save(trip, file = "data/trip.rda", compress = "xz")

usethis::use_data(trip, overwrite = TRUE, compress = "xz")
