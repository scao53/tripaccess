## code to prepare `house` dataset goes here

library(tidyverse)
nhts_data_dir <- Sys.getenv(
  "NHTS_2017_DATA_DIR",
  unset = "../di_pedagogy/original datasets"
)

hh <- read_csv(file.path(nhts_data_dir, "hhpub.csv"))

hh_selected <- hh |>
  select(HOUSEID, CENSUS_D, DRVRCNT, HHSIZE, HHVEHCNT, LIF_CYC, NUMADLT, WRKCOUNT, YOUNGCHILD) |>
  filter(LIF_CYC != "-9") |>
  mutate(CENSUS_D = case_when(CENSUS_D == "01" ~ "New England",
                              CENSUS_D == "02" ~ "Middle Atlantic",
                              CENSUS_D == "03" ~ "East North Central",
                              CENSUS_D == "04" ~ "West North Central",
                              CENSUS_D == "05" ~ "South Atlantic",
                              CENSUS_D == "06" ~ "East South Central",
                              CENSUS_D == "07" ~ "West South Central",
                              CENSUS_D == "08" ~ "Mountain",
                              CENSUS_D == "09" ~ "Pacific")) |>
  mutate(LIF_CYC = case_when(LIF_CYC == "01" ~ "one adult, no children",
                             LIF_CYC == "02" ~ "2+ adults, no children",
                             LIF_CYC == "03" ~ "one adult, youngest child 0-5",
                             LIF_CYC == "04" ~ "2+ adults, youngest child 0-5",
                             LIF_CYC == "05" ~ "one adult, youngest child 6-15",
                             LIF_CYC == "06" ~ "2+ adults, youngest child 6-15",
                             LIF_CYC == "07" ~ "one adult, youngest child 16-21",
                             LIF_CYC == "08" ~ "2+ adults, youngest child 16-21",
                             LIF_CYC == "09" ~ "one adult, retired, no children",
                             LIF_CYC == "10" ~ "2+ adults, retired, no children"))

hh_selected_rename <- hh_selected |>
  rename(household_id = HOUSEID,
         region = CENSUS_D,
         number_drivers = DRVRCNT,
         count_household_members = HHSIZE,
         number_vehicles = HHVEHCNT,
         household_life_cycle = LIF_CYC,
         count_adult_household_members = NUMADLT,
         number_workers = WRKCOUNT,
         count_young_child = YOUNGCHILD)

col_order <- c("household_id", "region", "number_drivers", "count_household_members", "number_vehicles", "household_life_cycle", "count_adult_household_members", "number_workers", "count_young_child")
house <- hh_selected_rename[, col_order]

save(house, file = "data/house.rda", compress = "xz")

usethis::use_data(house, overwrite = TRUE, compress = "xz")
