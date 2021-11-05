#' Estimate CVAP at the Block Level
#'
#' Assuming citizenship homogeneity within block group race/ethnicity, estimates
#' down from block groups to the block level, using the ratio of citizen voting
#' age population to population in the ACS year used multiplied by the block population
#' from the previous decennial census.
#'
#'
#' @param cvap cvap data at the block group level, using default settings of `get_cvap()`
#' @param block block data data for the Census before the year of the cvap data
#' @param block_group block group data for the same year (ending year, e.g.
#'  2015-2019 needs to be 2019)
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
#' cvap <- cvap_get(state)
#' de_block <- censable::build_dec(geography = 'block',
#' state = state, year = 2010, geometry = FALSE)
#' de_block_group <- censable::build_acs(geography = 'block group',
#' state = 'DE', geometry = FALSE, year = 2019)
#' }
#
#' # Alternatively, using example data
#' state <- 'DE'
#' cvap <- cvap_get(state)
#' data('de_block')
#' data('de_block_group')
#' cvap_block <- cvap_distribute(cvap, de_block, de_block_group)
cvap_distribute <- function(cvap, block, block_group) {
  block_group <- block_group %>% dplyr::select(
    dplyr::all_of('GEOID'),
    dplyr::starts_with('pop')
  )

  merged <- block_group %>%
    dplyr::left_join(cvap %>%
      dplyr::select(
        dplyr::all_of('GEOID'),
        dplyr::starts_with('cvap')
      ),
    by = 'GEOID'
    )

  # cvap per pop or 0 ----
  cvaps <- dplyr::select(merged, c(
    cvap, cvap_white, cvap_black, cvap_hisp, cvap_asian,
    cvap_aian, cvap_nhpi, cvap_two, cvap_other
  ))
  pops <- dplyr::select(merged, c(
    pop, pop_white, pop_black, pop_hisp, pop_asian,
    pop_aian, pop_nhpi, pop_two, pop_other
  ))

  props <- (cvaps / pops)

  props[is.na(props)] <- dplyr::if_else(pops[is.na(props)] == 0, 0, props[is.na(props)])

  props[sapply(props, simplify = 'matrix', is.infinite)] <- 0

  props[props > 1] <- 1

  props <- props %>%
    dplyr::mutate(bg_GEOID = merged$GEOID)

  # multiply block by cvap/pop by block group ----
  block <- block %>%
    dplyr::mutate(bg_GEOID = stringr::str_sub(GEOID, 1, 12)) %>%
    dplyr::left_join(props, by = 'bg_GEOID')

  block <- block %>%
    dplyr::mutate(
      cvap = pop * cvap,
      cvap_white = pop_white * cvap_white,
      cvap_black = pop_black * cvap_black,
      cvap_hisp = pop_hisp * cvap_hisp,
      cvap_asian = pop_asian * cvap_asian,
      cvap_aian = pop_aian * cvap_aian,
      cvap_nhpi = pop_nhpi * cvap_nhpi,
      cvap_two = pop_two * cvap_two,
      cvap_other = pop_other * cvap_other
    )

  block %>% dplyr::select(-dplyr::all_of('bg_GEOID'))
}

#' Distribute CVAP at the Block Group and Download Data
#'
#' Downloads CVAP, block data, and block group data all together.
#' Calls `cvap_distribute` within.
#'
#' @param state character. The state to get data for or nation for the nation file.
#' @param year numeric. Year for the data in 2009 to 2019.
#'
#' @return cvap tibble estimated at the block level
#' @export
#'
#' @concept distribute
#'
#' @examples
#' \dontrun{
#' # Requires API set up with tidycensus or censable
#' distribute_cvap_with_api('DE', 2019)
#' }
#'
cvap_distribute_censable <- function(state, year = 2019) {
  state <- censable::match_abb(state)
  b_year <- year - (year %% 10)

  cvap <- cvap_get(state, year)

  block <- censable::build_dec(
    geography = 'block', state = state,
    year = b_year, geometry = FALSE
  )
  block_group <- censable::build_acs(
    geography = 'block group', state = state,
    geometry = FALSE, year = year
  )

  cvap_distribute(cvap, block, block_group)
}
