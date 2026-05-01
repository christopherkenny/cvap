# Download Processed VEST Block Crosswalk

Provides a friendlier data format for R for working with VEST
crosswalks. Data can be retallied with `PL94171::pl_retally()` using
this crosswalk.

## Usage

``` r
vest_crosswalk(state)
```

## Arguments

- state:

  character. The state to get the VEST crosswalk for.

## Value

tibble

## References

Amos, Brian, 2021, "2020 Census Block Crosswalk Data",
https://doi.org/10.7910/DVN/T9VMJO, Harvard Dataverse, V2

## Examples

``` r
de_cw <- vest_crosswalk('DE')
```
