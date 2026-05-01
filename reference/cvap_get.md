# Download Processed Citizen Voting Age Population Data

Downloads processed CVAP data for a state. CVAP data is rounded to the
nearest 5 so totals may not sum properly, but will be close.

## Usage

``` r
cvap_get(
  state,
  year = 2023,
  geography = "block group",
  out_file = NULL,
  moe = FALSE,
  clean = TRUE
)
```

## Arguments

- state:

  character. The state to get data for or nation for the nation file.

- year:

  numeric. Year for the data in 2009 to 2023.

- geography:

  character. Level of geography. Default is 'block group'. See Details.

- out_file:

  file to save downloaded rds to

- moe:

  Include margin of error? Default is FALSE.

- clean:

  Should variable names be standardized? Default is TRUE.

## Value

tibble of data

## Details

Geography options are

- 'block group': block group level data

- 'cd': congressional district data (years 2016+)

- 'county': county-level data

- 'place': place-level data

- shd': state house district data (years 2016+)

- 'ssd': state senate district data (years 2016+)

- 'state': state-level data

- 'tract': tract-level data

- 'nation': nation-wide data

## Examples

``` r
cvap_get('DE')
#> # A tibble: 706 × 10
#>    GEOID     cvap cvap_white cvap_black cvap_hisp cvap_asian cvap_aian cvap_nhpi
#>    <chr>    <dbl>      <dbl>      <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1000104…  1245       1115         35        90          0         0         0
#>  2 1000104…  1795       1600        180        15          0         4         0
#>  3 1000104…  1435       1330        105         0          0         0         0
#>  4 1000104…   890        725         95        65          0         0         0
#>  5 1000104…  1715       1260        335        80         25         0         0
#>  6 1000104…   710        470        225        15          0         0         0
#>  7 1000104…  1370        590        525       160          4        10         0
#>  8 1000104…  1025        770        150       105          0         0         0
#>  9 1000104…  1135        580        325       185         35         0         0
#> 10 1000104…  1550        780        585       180          0         0         0
#> # ℹ 696 more rows
#> # ℹ 2 more variables: cvap_two <dbl>, cvap_other <dbl>
```
