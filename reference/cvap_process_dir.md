# Process Directory of CVAP Files

Process Directory of CVAP Files

## Usage

``` r
cvap_process_dir(dir, year, out_dir, moe = TRUE, csv = FALSE)
```

## Arguments

- dir:

  Path to directory with the CVAP files

- year:

  file year

- out_dir:

  directory to create files in

- moe:

  Boolean. Default is TRUE. Should margin of error be kept?

- csv:

  Boolean. Default is FALSE, which creates an rds file instead.

## Value

list of tibbles of cvap

## Examples

``` r
path <- fs::path_package('cvap', 'extdata')
cvap_process_dir(path, year = 2019, out_dir = tempdir())
#> [[1]]
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
#> 
#> [[2]]
#> # A tibble: 1 × 26
#>   GEOID geoname        cvap cvap_aian cvap_asian cvap_black cvap_nhpi cvap_white
#>   <chr> <chr>         <dbl>     <dbl>      <dbl>      <dbl>     <dbl>      <dbl>
#> 1 ""    United Stat… 2.31e8   1597975    9940500   28930220    349015  157517975
#> # ℹ 18 more variables: cvap_white_aian <dbl>, cvap_white_asian <dbl>,
#> #   cvap_white_black <dbl>, cvap_black_aian <dbl>, cvap_two <dbl>,
#> #   cvap_hisp <dbl>, cvap_moe <dbl>, cvap_moe_aian <dbl>, cvap_moe_asian <dbl>,
#> #   cvap_moe_black <dbl>, cvap_moe_nhpi <dbl>, cvap_moe_white <dbl>,
#> #   cvap_moe_white_aian <dbl>, cvap_moe_white_asian <dbl>,
#> #   cvap_moe_white_black <dbl>, cvap_moe_black_aian <dbl>, cvap_moe_two <dbl>,
#> #   cvap_moe_hisp <dbl>
#> 
```
