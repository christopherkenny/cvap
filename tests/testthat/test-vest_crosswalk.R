test_that("vest_crosswalk works", {
  cw <- NULL
  try({cw <- vest_crosswalk('WY')})
  skip_if(is.null(cw), message = 'Crosswalk did not download for testing.')
  expect_s3_class(cw, 'data.frame')
})
