test_that("distribute works", {
  cvap_block <- cvap_distribute(cvap, de_block, de_block_group)
  expect_s3_class(cvap_block, 'data.frame')
  expect_equal(floor(sum(cvap_block$cvap)), 667393)
})
