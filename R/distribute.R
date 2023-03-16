#' Estimate CVAP at the Block Level
#'
#' Assuming citizenship homogeneity within block group race/ethnicity, estimates
#' down from block groups to the block level, proportionally by group if possible,
#' otherwise by total population.
#'
#'
#' @param cvap cvap data at the block group level, using default settings of `get_cvap()`
#' @param block block data data for the Census before (or the same as) the year of the cvap data
#' @param wts `'pop'` (default) or `'vap'` for the group to distribute by.
#' @param include_implied logical if a column for the implied total (`impl_cvap`) should be included. Default is `TRUE`
#'
#' @return cvap tibble estimated at the block level
#' @export
#' @concept distribute
#'
#' @md
#' @examples
#' \dontrun{
#' # Requires API set up with tidycensus
#' state <- 'DE'
#' cvap <- cvap_get(state, year = 2019)
#' de_block <- censable::build_dec(geography = 'block',
#' state = state, year = 2010, geometry = FALSE)
#' }
#
#' # Alternatively, using example data
#' state <- 'DE'
#' cvap <- cvap_get(state, year = 2019)
#' data('de_block')
#' cvap_block <- cvap_distribute(cvap, de_block)
#'
cvap_distribute <- function(cvap, block, wts = 'pop', include_implied = TRUE) {
  match.arg(wts, choices = c('pop', 'vap'))
  block <- block %>%
    dplyr::mutate(bg_GEOID = stringr::str_sub(string = .data$GEOID, 1, 12))

  matches <- match(block$bg_GEOID, cvap$GEOID)
  noms <- cvap %>%
    dplyr::select(dplyr::starts_with('cvap')) %>%
    names()
  b_cvap <- lapply(
    X = noms,
    FUN = function(name) {
      what <- paste0(wts, stringr::str_sub(name, 5))
      if (!what %in% names(block)) {
        what <- wts
      }
      estimate_down(wts = block[[what]], value = cvap[[name]], group = matches)
    }
  ) %>%
    do.call(what = 'cbind') %>%
    `colnames<-`(value = noms) %>%
    dplyr::as_tibble()

  out <- block %>%
    dplyr::bind_cols(
      b_cvap
    )

  if (include_implied) {
    out$impl_cvap <- out %>%
      dplyr::select(dplyr::starts_with('cvap_')) %>%
      as.matrix() %>%
      rowSums()
  }

  out
}

#' Distribute CVAP at the Block Group and Download Data
#'
#' Downloads CVAP, block data, and block group data all together.
#' Calls `cvap_distribute` within.
#'
#' @param state character. The state to get data for or nation for the nation file.
#' @param year numeric. Year for the data in 2009 to 2021.
#' @param clean Should variable names be standardized? Default is TRUE.
#' @param wts 'pop' (default) or 'vap' for the group to distribute by.
#' @param include_implied logical if a column for the implied total (`impl_cvap`) should be included. Default is `TRUE`
#'
#' @return cvap tibble estimated at the block level
#' @export
#'
#' @concept distribute
#'
#' @examples
#' \dontrun{
#' # Requires API set up with tidycensus or censable
#' cvap_distribute_censable('DE', 2019)
#' }
#'
cvap_distribute_censable <- function(state, year = 2021, clean = TRUE, wts = 'pop', include_implied = TRUE) {
  state <- censable::match_abb(state)
  b_year <- year - (year %% 10)

  cvap <- cvap_get(state, year, clean = clean)

  block <- censable::build_dec(
    geography = 'block', state = state,
    year = b_year, geometry = FALSE
  )

  cvap_distribute(cvap, block, wts = wts, include_implied)
}
