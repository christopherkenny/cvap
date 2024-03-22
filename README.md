
<!-- README.md is generated from README.Rmd. Please edit that file -->

\# cvap
<a href='https://christophertkenny.com/cvap/'><img src='man/figures/logo.png' align="right" height="138" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/cvap)](https://CRAN.R-project.org/package=cvap)
[![cvap status
badge](https://christopherkenny.r-universe.dev/badges/cvap)](https://christopherkenny.r-universe.dev/cvap)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/christopherkenny/cvap/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/christopherkenny/cvap/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of `cvap` is to work with Census citizen voting-age population
(CVAP) data.

## Installation

You can install the released version of cvap from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("cvap")
```

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("christopherkenny/cvap")
```

## Example

The primary tools from this package are to first download CVAP data
that’s already processed.

``` r
library(cvap)
de_cvap <- cvap_get('DE')
```

`cvap_get()` has options for the available geographies in the [Census
special
tabulation](https://www.census.gov/programs-surveys/decennial-census/about/voting-rights/cvap.html).

With that data, we can combine it with ACS and Decennial Census data to
estimate block-level data.

``` r
de_block <- censable::build_dec(geography = 'block', state = 'DE', 
                                year = 2010, geometry = FALSE)
de_block_group <- censable::build_acs(geography = 'block group', state = 'DE', 
                                      geometry = FALSE, year = 2019)
```

For example purposes, the 2010 Delaware Census block data is provided:

``` r
data('de_block')
```

Along with the Delaware 2019 ACS data:

``` r
data('de_block_group')
```

This allows us to distribute the block group data approximately between
blocks.

``` r
block_est <- cvap_distribute(de_cvap, de_block_group)
#> New names:
#> • `cvap` -> `cvap...21`
#> • `cvap_white` -> `cvap_white...22`
#> • `cvap_black` -> `cvap_black...23`
#> • `cvap_hisp` -> `cvap_hisp...24`
#> • `cvap_aian` -> `cvap_aian...25`
#> • `cvap_asian` -> `cvap_asian...26`
#> • `cvap_nhpi` -> `cvap_nhpi...27`
#> • `cvap_other` -> `cvap_other...28`
#> • `cvap_two` -> `cvap_two...29`
#> • `cvap` -> `cvap...31`
#> • `cvap_white` -> `cvap_white...32`
#> • `cvap_black` -> `cvap_black...33`
#> • `cvap_hisp` -> `cvap_hisp...34`
#> • `cvap_asian` -> `cvap_asian...35`
#> • `cvap_aian` -> `cvap_aian...36`
#> • `cvap_nhpi` -> `cvap_nhpi...37`
#> • `cvap_two` -> `cvap_two...38`
#> • `cvap_other` -> `cvap_other...39`
```

This workflow can also be combined into one function

``` r
block_est <- cvap_distribute_censable('DE')
```

The resulting data has estimated CVAP data for each block:

``` r
dplyr::glimpse(block_est)
#> Rows: 574
#> Columns: 40
#> $ GEOID           <chr> "100030101042", "100010412002", "100010411002", "10001…
#> $ NAME            <chr> "Block Group 2, Census Tract 101.04, New Castle County…
#> $ pop             <dbl> 1909, 2595, 1068, 2852, 0, 473, 63, 35, 53, 781, 57, 2…
#> $ pop_white       <dbl> 1006, 1067, 713, 1986, 0, 459, 56, 35, 51, 745, 57, 26…
#> $ pop_black       <dbl> 629, 932, 94, 297, 0, 0, 0, 0, 0, 20, 0, 0, 0, 278, 73…
#> $ pop_hisp        <dbl> 244, 103, 242, 451, 0, 7, 7, 0, 0, 5, 0, 6, 0, 240, 95…
#> $ pop_aian        <dbl> 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0…
#> $ pop_asian       <dbl> 0, 376, 4, 8, 0, 7, 0, 0, 2, 4, 0, 0, 0, 488, 74, 0, 0…
#> $ pop_nhpi        <dbl> 0, 19, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ pop_other       <dbl> 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ pop_two         <dbl> 30, 82, 10, 75, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 77, 0, 0…
#> $ vap             <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ vap_white       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ vap_black       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ vap_hisp        <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ vap_aian        <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ vap_asian       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ vap_nhpi        <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ vap_other       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ vap_two         <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ cvap...21       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ cvap_white...22 <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ cvap_black...23 <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ cvap_hisp...24  <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ cvap_aian...25  <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ cvap_asian...26 <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ cvap_nhpi...27  <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ cvap_other...28 <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ cvap_two...29   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ bg_GEOID        <chr> "100030101042", "100010412002", "100010411002", "10001…
#> $ cvap...31       <dbl> 1120, 805, 0, 0, 0, 545, 155, 20, 35, 710, 250, 350, 2…
#> $ cvap_white...32 <dbl> 630, 415, 0, 0, 0, 535, 150, 20, 30, 605, 250, 270, 25…
#> $ cvap_black...33 <dbl> 350, 150, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 140, 0, 0,…
#> $ cvap_hisp...34  <dbl> 120, 15, 0, 0, 0, 4, 4, 0, 4, 15, 0, 4, 0, 265, 310, 0…
#> $ cvap_asian...35 <dbl> 0, 35, 0, 0, 0, 4, 0, 0, 4, 4, 0, 0, 0, 45, 0, 0, 195,…
#> $ cvap_aian...36  <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 4, 0, 10, 0, 0, 0, 0…
#> $ cvap_nhpi...37  <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ cvap_two...38   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 0,…
#> $ cvap_other...39 <dbl> 20, 190, 0, 0, 0, 2, 1, 0, 0, 0, 0, 72, 0, 45, 0, 0, 2…
#> $ impl_cvap       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
```

Thus, using other packages like `PL94171`, we can easily aggregate this
from blocks to VTDs, where CVAP is not directly provided.
`vest_crosswalk` allows you to download a variant of VEST’s crosswalk
that is computationally more favorable for R.
