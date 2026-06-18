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
