clean_LNTITLE <- function(data) {
  data |> dplyr::mutate(LNTITLE = dplyr::case_when(
    .data$LNTITLE == 'Total' ~ '',
    .data$LNTITLE == 'Not Hispanic or Latino' ~ 'not_hisp',
    .data$LNTITLE == 'American Indian or Alaska Native Alone' ~ 'aian',
    .data$LNTITLE == 'Asian Alone' ~ 'asian',
    .data$LNTITLE == 'Black or African American Alone' ~ 'black',
    .data$LNTITLE == 'Native Hawaiian or Other Pacific Islander Alone' ~ 'nhpi',
    .data$LNTITLE == 'White Alone' ~ 'white',
    .data$LNTITLE == 'American Indian or Alaska Native and White' ~ 'white_aian',
    .data$LNTITLE == 'Asian and White' ~ 'white_asian',
    .data$LNTITLE == 'Black or African American and White' ~ 'white_black',
    .data$LNTITLE == 'American Indian or Alaska Native and Black or African American' ~ 'black_aian',
    .data$LNTITLE == 'Remainder of Two or More Race Responses' ~ 'two',
    .data$LNTITLE == 'Hispanic or Latino' ~ 'hisp',
    TRUE ~ 'uh_oh'
  ))
}

clean_cvap_names <- function(data) {
  noms <- names(data)
  noms <- noms |>
    stringr::str_remove('_EST') |>
    stringr::str_to_lower()
  noms[noms == 'geoid'] <- 'GEOID'
  names(data) <- noms

  data
}

validate_year <- function(year) {
  if (length(year) > 1) {
    cli::cli_warn('Only one year is supported at a time. Using only the first entry.')
    year <- year[1]
  }

  if (year < 2009 || year > 2022) {
    cli::cli_abort('Only years from 2009 to 2022 supported.')
  }

  year
}

validate_geography <- function(geography, year) {
  if (length(geography) > 1) {
    cli::cli_warn('Only one geography is supported at a time. Using only the first entry.')
    geography <- geography[1]
  }
  if (year < 16 && geography %in% c('cd', 'shd', 'ssd')) {
    cli::cli_abort('cd, shd, and ssd inputs only available for 2016 or later')
  }

  v_09_17 <- c(
    'blockgr', 'cd', 'county', 'place',
    'sldl', 'sldu', 'state', 'tract', 'nation'
  )
  v_18_20 <- c(
    'blockgr', 'cd', 'county', 'place',
    'sldlc', 'slduc', 'state', 'tract', 'nation'
  )
  vals <- c(
    'block group', 'cd', 'county', 'place',
    'shd', 'ssd', 'state', 'tract', 'nation'
  )
  if (year < 2018) {
    out <- v_09_17[which(geography == vals)]
  } else {
    out <- v_18_20[which(geography == vals)]
  }

  out
}
