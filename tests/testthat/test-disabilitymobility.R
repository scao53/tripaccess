# It is expected that all data has been stored in the same way as the source data.
# For disabilitymobility: household_id, person_id

test_that("datasets are unchanged", {
  expect_snapshot(cat(format(tidytree::as_tibble(disabilitymobility)[1:3, c("household_id", "person_id")])[-3L], sep = "\n"))
})
