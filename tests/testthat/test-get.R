test_that("cvap_get default works", {
  de <- cvap_get('DE', year = 2019)
  expect_equal(sum(de$cvap), 710270)
})

test_that("cvap_get other geography works", {
  de <- cvap_get('DE', geography =  'block group', year = 2019)
  expect_equal(sum(de$cvap), 710270)
})

test_that("cvap_get default works year 2021", {
  de <- cvap_get('DE', year = 2021)
  expect_equal(sum(de$cvap), 733725)
})
