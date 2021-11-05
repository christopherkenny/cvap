test_that("cvap_get default works", {
  de <- cvap_get('DE')
  expect_equal(sum(de$cvap), 710270)
})

test_that("cvap_get other geography works", {
  de <- cvap_get('DE', geography =  'block group')
  expect_equal(sum(de$cvap), 710270)
})
