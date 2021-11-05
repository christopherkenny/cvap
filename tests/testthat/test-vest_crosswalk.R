test_that("vest_crosswalk works", {
  cw <- vest_crosswalk('WY')
  expect_s3_class(cw, 'data.frame')
})
