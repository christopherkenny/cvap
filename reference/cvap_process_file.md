# Process Census CVAP File

Process Census CVAP File

## Usage

``` r
cvap_process_file(path, year, out_dir, moe = TRUE, csv = FALSE)
```

## Arguments

- path:

  path to csv file

- year:

  file year

- out_dir:

  directory to create files in

- moe:

  Boolean. Default is TRUE. Should margin of error be kept?

- csv:

  Boolean. Default is FALSE, which creates an rds file instead.

## Value

tibble of cvap data

## Examples

``` r
path <- fs::path_package('cvap', 'extdata', 'County.csv')
cvap_process_file(path, year = 2019, out_dir = tempdir())
#> # A tibble: 3 × 27
#>   GEOID geoname        cvap cvap_aian cvap_asian cvap_black cvap_nhpi cvap_white
#>   <chr> <chr>         <dbl>     <dbl>      <dbl>      <dbl>     <dbl>      <dbl>
#> 1 10001 Kent County… 131145       855       2205      32175       120      86485
#> 2 10003 New Castle … 405495      1050      12565      99600       110     262355
#> 3 10005 Sussex Coun… 173640       660       1740      18960        60     143940
#> # ℹ 19 more variables: cvap_white_aian <dbl>, cvap_white_asian <dbl>,
#> #   cvap_white_black <dbl>, cvap_black_aian <dbl>, cvap_two <dbl>,
#> #   cvap_hisp <dbl>, cvap_moe <dbl>, cvap_moe_aian <dbl>, cvap_moe_asian <dbl>,
#> #   cvap_moe_black <dbl>, cvap_moe_nhpi <dbl>, cvap_moe_white <dbl>,
#> #   cvap_moe_white_aian <dbl>, cvap_moe_white_asian <dbl>,
#> #   cvap_moe_white_black <dbl>, cvap_moe_black_aian <dbl>, cvap_moe_two <dbl>,
#> #   cvap_moe_hisp <dbl>, state <chr>
```
