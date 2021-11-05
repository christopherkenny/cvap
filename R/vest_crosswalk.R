#' Download Processed VEST Block Crosswalk
#'
#' Provides a friendlier data format for R for working with VEST crosswalks.
#' Data can be retallied with `PL94171::pl_retally()` using this crosswalk.
#'
#' @param state character. The state to get the VEST crosswalk for.
#'
#' @return tibble
#' @export
#'
#' @references
#' Amos, Brian, 2021, "2020 Census Block Crosswalk Data",
#' https://doi.org/10.7910/DVN/T9VMJO, Harvard Dataverse, V2
#'
#' @examples
#' de_cw <- vest_crosswalk('DE')
vest_crosswalk <- function(state) {
  state <- censable::match_abb(state)
  url <- paste0('https://github.com/alarm-redist/census-2020/raw/main/crosswalks/',
                state, '.rds')
  file <- fs::file_temp(ext = 'rds')
  utils::download.file(url = url, destfile = file)
  readRDS(file)
}
