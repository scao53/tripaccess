# It is expected that all data has been stored in the same way as the source data, using the first three rows and the first five columns as well as the numbers of rows and columns of the entire datasets to test.

test_that("datasets are unchanged", {
  expect_snapshot(cat(format(tidytree::as_tibble(tripaccess)[1:3, 1:5])[-3L], sep = "\n"))
  expect_snapshot(nrow(tripaccess))
  expect_snapshot(ncol(tripaccess))

  expect_snapshot(cat(format(tidytree::as_tibble(person)[1:3, 1:5])[-3L], sep = "\n"))
  expect_snapshot(nrow(person))
  expect_snapshot(ncol(person))

  expect_snapshot(cat(format(tidytree::as_tibble(house)[1:3, 1:5])[-3L], sep = "\n"))
  expect_snapshot(nrow(house))
  expect_snapshot(ncol(house))

  expect_snapshot(cat(format(tidytree::as_tibble(trip)[1:3, 1:5])[-3L], sep = "\n"))
  expect_snapshot(nrow(trip))
  expect_snapshot(ncol(trip))
})

test_that("person dataset has the expected structure", {
  expected_names <- c(
    "household_id",
    "person_id",
    "travel_disability",
    "sex",
    "race",
    "hispanic_ethnicity",
    "nativity",
    "age",
    "education",
    "self_rated_health",
    "employment_status",
    "household_income",
    "household_structure",
    "population_density",
    "urban_rural",
    "state",
    "driver_status",
    "cane",
    "manual_wheelchair",
    "crutches",
    "dog",
    "motorized_wheelchair",
    "scooter",
    "white_cane",
    "walker",
    "other_accommodation",
    "yearly_miles_personally_driven",
    "count_of_public_transit_usage",
    "count_of_rideshare_app_usage",
    "count_of_bike_trips",
    "count_of_walk_trips",
    "count_of_online_delivery"
  )

  expect_s3_class(person, "data.frame")
  expect_equal(nrow(person), 99564)
  expect_equal(ncol(person), 32)
  expect_named(person, expected_names)
  expect_identical(dplyr::group_vars(person), character(0))
})

test_that("person numeric variables stay within documented ranges", {
  expect_gte(min(person$age), 18)
  expect_lte(max(person$age), 61)

  expected_ranges <- list(
    yearly_miles_personally_driven = c(0, 200000),
    count_of_public_transit_usage = c(0, 30),
    count_of_rideshare_app_usage = c(0, 99),
    count_of_bike_trips = c(0, 99),
    count_of_walk_trips = c(0, 200),
    count_of_online_delivery = c(0, 99)
  )

  for (var in names(expected_ranges)) {
    expect_false(anyNA(person[[var]]))
    expect_gte(min(person[[var]]), expected_ranges[[var]][1])
    expect_lte(max(person[[var]]), expected_ranges[[var]][2])
  }
})

test_that("house dataset has the expected structure", {
  expected_names <- c(
    "household_id",
    "region",
    "number_drivers",
    "count_household_members",
    "number_vehicles",
    "household_life_cycle",
    "count_adult_household_members",
    "number_workers",
    "count_young_child"
  )

  expect_s3_class(house, "data.frame")
  expect_equal(nrow(house), 129695)
  expect_equal(ncol(house), 9)
  expect_named(house, expected_names)
  expect_identical(dplyr::group_vars(house), character(0))
})

test_that("house categorical variables use documented labels", {
  expected_regions <- c(
    "New England",
    "Middle Atlantic",
    "East North Central",
    "West North Central",
    "South Atlantic",
    "East South Central",
    "West South Central",
    "Mountain",
    "Pacific"
  )

  expected_life_cycles <- c(
    "one adult, no children",
    "2+ adults, no children",
    "one adult, youngest child 0-5",
    "2+ adults, youngest child 0-5",
    "one adult, youngest child 6-15",
    "2+ adults, youngest child 6-15",
    "one adult, youngest child 16-21",
    "2+ adults, youngest child 16-21",
    "one adult, retired, no children",
    "2+ adults, retired, no children"
  )

  expect_false(anyNA(house$region))
  expect_false(anyNA(house$household_life_cycle))
  expect_setequal(unique(house$region), expected_regions)
  expect_setequal(unique(house$household_life_cycle), expected_life_cycles)
})

test_that("house numeric variables stay within documented ranges", {
  expected_ranges <- list(
    number_drivers = c(0, 9),
    count_household_members = c(1, 13),
    number_vehicles = c(0, 12),
    count_adult_household_members = c(1, 10),
    number_workers = c(0, 7),
    count_young_child = c(0, 5)
  )

  for (var in names(expected_ranges)) {
    expect_false(anyNA(house[[var]]))
    expect_gte(min(house[[var]]), expected_ranges[[var]][1])
    expect_lte(max(house[[var]]), expected_ranges[[var]][2])
  }
})

test_that("trip dataset has the expected structure", {
  expected_names <- c(
    "household_id",
    "person_id",
    "trip_purpose",
    "gas_price",
    "num_of_people_on_trip",
    "trip_miles",
    "trip_duration",
    "trip_miles_personally_driven_vehicle"
  )

  expect_s3_class(trip, "data.frame")
  expect_equal(nrow(trip), 921590)
  expect_equal(ncol(trip), 8)
  expect_named(trip, expected_names)
  expect_identical(dplyr::group_vars(trip), character(0))
})

test_that("trip categorical variables use documented labels", {
  expected_trip_purposes <- c(
    "shopping_trip",
    "other_home_based_trip",
    "social_recreational_trip",
    "work_trip",
    "other_non_home_based_trip"
  )

  expect_false(anyNA(trip$trip_purpose))
  expect_setequal(unique(trip$trip_purpose), expected_trip_purposes)
})

test_that("trip numeric variables stay within documented ranges", {
  expected_ranges <- list(
    gas_price = c(201.3, 295.9),
    num_of_people_on_trip = c(1, 401),
    trip_miles = c(0, 9621.053),
    trip_duration = c(0, 1200),
    trip_miles_personally_driven_vehicle = c(-1, 1425.808)
  )

  for (var in names(expected_ranges)) {
    expect_false(anyNA(trip[[var]]))
    expect_gte(min(trip[[var]]), expected_ranges[[var]][1])
    expect_lte(max(trip[[var]]), expected_ranges[[var]][2])
  }
})
