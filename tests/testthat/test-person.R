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

test_that("person categorical variables are recoded for teaching use", {
  expect_setequal(unique(person$nativity), c("Yes", "No"))
  expect_false(any(person$nativity %in% c("01", "02")))

  expect_setequal(unique(person$sex), c("Male", "Female"))
  expect_setequal(unique(person$hispanic_ethnicity), c("Hispanic", "Non-Hispanic"))
  expect_setequal(unique(person$urban_rural), c("Urban", "Rural"))
  expect_setequal(unique(person$driver_status), c("Drives", "Does not drive"))

  disability_values <- c(
    "6_months_or_less_disability",
    "More_than_6_months_of_disability",
    "Lifelong_disability",
    "No_disability"
  )
  expect_setequal(unique(person$travel_disability), disability_values)
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

test_that("person mobility aid variables use True and False labels", {
  mobility_aid_vars <- c(
    "cane",
    "manual_wheelchair",
    "crutches",
    "dog",
    "motorized_wheelchair",
    "scooter",
    "white_cane",
    "walker",
    "other_accommodation"
  )

  for (var in mobility_aid_vars) {
    expect_setequal(unique(person[[var]]), c("True", "False"))
  }
})
