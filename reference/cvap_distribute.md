# Estimate CVAP at the Block Level

Assuming citizenship homogeneity within block group race/ethnicity,
estimates down from block groups to the block level, proportionally by
group if possible, otherwise by total population.

## Usage

``` r
cvap_distribute(cvap, block, wts = "pop", include_implied = TRUE)
```

## Arguments

- cvap:

  cvap data at the block group level, using default settings of
  `get_cvap()`

- block:

  block data data for the Census before (or the same as) the year of the
  cvap data

- wts:

  `'pop'` (default) or `'vap'` for the group to distribute by.

- include_implied:

  logical if a column for the implied total (`impl_cvap`) should be
  included. Default is `TRUE`

## Value

cvap tibble estimated at the block level

## Examples

``` r
if (FALSE) { # \dontrun{
# Requires API set up with tidycensus
state <- 'DE'
cvap <- cvap_get(state, year = 2019)
de_block <- censable::build_dec(geography = 'block',
state = state, year = 2010, geometry = FALSE)
} # }
# Alternatively, using example data
state <- 'DE'
cvap <- cvap_get(state, year = 2019)
data('de_block')
cvap_block <- cvap_distribute(cvap, de_block)
```
