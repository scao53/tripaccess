## code to prepare `house` dataset goes here

library(tidyverse)
nhts_data_dir <- Sys.getenv(
  "NHTS_2017_DATA_DIR",
  unset = "../di_pedagogy/original datasets"
)

hh <- read_csv(file.path(nhts_data_dir, "hhpub.csv"))

hh_selected <- hh |>
  select(HOUSEID, CENSUS_D, DRVRCNT, HHSIZE, HHVEHCNT, LIF_CYC, NUMADLT, WRKCOUNT, YOUNGCHILD) |>
  filter(LIF_CYC != "-9")

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
