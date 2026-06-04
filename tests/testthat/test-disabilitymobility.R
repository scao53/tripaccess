# It is expected that all data has been stored in the same way as the source data, using the first three rows and the first five columns as well as the numbers of rows and columns of the entire datasets to test.

test_that("datasets are unchanged", {
  expect_snapshot(cat(format(tidytree::as_tibble(disabilitymobility)[1:3, 1:5])[-3L], sep = "\n"))
  expect_snapshot(nrow(disabilitymobility))
  expect_snapshot(ncol(disabilitymobility))
})
