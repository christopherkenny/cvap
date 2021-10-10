#' Get Zip File URL for CVAP Special Tabulation Data
#'
#' @param year numeric. Year for the data in 2009 to 2019.
#'
#' @return string
#' @export
#'
#' @concept raw
#' @examples
#' cvap_census_url()
cvap_census_url <- function(year = 2019) {
  stringr::str_glue('https://www2.census.gov/programs-surveys/decennial/rdo/datasets/{year}/{year}-cvap/CVAP_{year - 4}-{year}_ACS_csv_files.zip')
}
