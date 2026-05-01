# Changelog

## cvap 0.1.7

- Correctly allocates AIAN + Black, AIAN + White, Asian + White, and
  Black + White to `*_two` columns in
  [`cvap_get()`](http://www.christophertkenny.com/cvap/reference/cvap_get.md).

## cvap 0.1.6

CRAN release: 2025-09-02

- Adds support for 2023 CVAP estimates. Default year updated to 2023.

## cvap 0.1.5

CRAN release: 2024-03-21

- Adds support for 2022 CVAP estimates. Default year updated to 2022.

## cvap 0.1.4

CRAN release: 2023-07-01

- Resolves a testing error on CRAN

## cvap 0.1.3

CRAN release: 2023-03-17

- Adds support for 2021 CVAP estimates. Default year updated to 2021.
- Adds a new option to include the “implied” total of the `cvap` columns
  in
  [`cvap_distribute()`](http://www.christophertkenny.com/cvap/reference/cvap_distribute.md)
  and
  [`cvap_distribute_censable()`](http://www.christophertkenny.com/cvap/reference/cvap_distribute_censable.md).
  It is named `impl_cvap` and resolves
  ([\#2](https://github.com/christopherkenny/cvap/issues/2)).

## cvap 0.1.2

- Adds support for
  [`cvap_distribute()`](http://www.christophertkenny.com/cvap/reference/cvap_distribute.md)
  to distribute by ‘vap’. Default remains ‘pop’.

## cvap 0.1.0

- Adds support for 2020 CVAP estimates
- Improves
  [`cvap_distribute()`](http://www.christophertkenny.com/cvap/reference/cvap_distribute.md)
  to avoid population loss, following the `geomander::estimate_down()`
  approach.
- Adds `clean` argument to
  [`cvap_distribute_censable()`](http://www.christophertkenny.com/cvap/reference/cvap_distribute_censable.md)

## cvap 0.0.3

CRAN release: 2021-11-08

- Added a `NEWS.md` file to track changes to the package.
- Fix logo link redirect
