# Get Raw Citizen Voting Age Population Files

Get Raw Citizen Voting Age Population Files

## Usage

``` r
cvap_get_raw(url, out_dir)
```

## Arguments

- url:

  URL to CVAP zip to download. Use
  [`cvap_census_url()`](http://www.christophertkenny.com/cvap/reference/cvap_census_url.md).

- out_dir:

  Directory to unzip to. Defaults to temp directory.

## Value

string, path where the data is saved

## Examples

``` r
# \donttest{
# takes 10-20 seconds
path <- cvap_get_raw(cvap_census_url())
# }
```
