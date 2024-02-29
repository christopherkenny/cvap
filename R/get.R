#' Download Processed Citizen Voting Age Population Data
#'
#' Downloads processed CVAP data for a state. CVAP data is rounded to the nearest 5
#' so totals may not sum properly, but will be close.
#'
#' Geography options are
#'
#' - 'block group': block group level data
#' - 'cd': congressional district data (years 2016+)
#' - 'county': county-level data
#' - 'place': place-level data
#' - shd': state house district data (years 2016+)
#' - 'ssd': state senate district data (years 2016+)
#' - 'state': state-level data
#' - 'tract': tract-level data
#' - 'nation': nation-wide data
#'
#' @param state character. The state to get data for or nation for the nation file.
#' @param year numeric. Year for the data in 2009 to 2022.
#' @param geography character. Level of geography. Default is 'block group'. See Details.
#' @param out_file file to save downloaded rds to
#' @param moe Include margin of error? Default is FALSE.
#' @param clean Should variable names be standardized? Default is TRUE.
#'
#' @concept download
#'
#' @return tibble of data
#' @export
#'
#' @examples
#' cvap_get('DE')
cvap_get <- function(state, year = 2022, geography = 'block group', out_file = NULL, moe = FALSE, clean = TRUE) {
  base_url <- 'https://github.com/christopherkenny/cvap_data/raw/main/'
  year <- validate_year(year)
  geography <- validate_geography(geography, year)

  if (state == 'nation') {
    geography <- 'us'
  } else {
    state <- censable::match_abb(state)
  }

  url <- stringr::str_glue('{base_url}{state}/{geography}_{year}.rds')

  if (is.null(out_file)) {
    out_file <- fs::file_temp(ext = 'rds')
  }

  utils::download.file(url, out_file)

  out <- readr::read_rds(out_file)

  if (!moe) {
    out <- out |> dplyr::select(-dplyr::contains('_moe'))
  }

  if (clean) {
    out <- out |>
      dplyr::select(dplyr::any_of(c(
        'GEOID', 'cvap', 'cvap_white', 'cvap_black',
        'cvap_hisp', 'cvap_asian', 'cvap_aian', 'cvap_nhpi', 'cvap_two'
      ))) |>
      dplyr::rowwise() |>
      dplyr::mutate(cvap_other = max(cvap - cvap_white - cvap_black - cvap_hisp - cvap_asian - cvap_aian - cvap_nhpi - cvap_two, 0)) |>
      dplyr::ungroup()
    readr::write_rds(out, out_file, 'xz')
  }

  out
}
