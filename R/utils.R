clean_LNTITLE <- function(data) {
  data %>% dplyr::mutate(LNTITLE = dplyr::case_when(
    .data$LNTITLE == "Total" ~ '',
    .data$LNTITLE == "Not Hispanic or Latino" ~ 'not_hisp',
    .data$LNTITLE == "American Indian or Alaska Native Alone" ~ 'aian',
    .data$LNTITLE == "Asian Alone" ~ 'asian',
    .data$LNTITLE == "Black or African American Alone" ~ 'black',
    .data$LNTITLE == "Native Hawaiian or Other Pacific Islander Alone" ~ 'nhpi',
    .data$LNTITLE == "White Alone" ~ 'white',
    .data$LNTITLE == "American Indian or Alaska Native and White" ~ 'white_aian',
    .data$LNTITLE == "Asian and White" ~ 'white_asian',
    .data$LNTITLE == "Black or African American and White" ~ 'white_black',
    .data$LNTITLE == "American Indian or Alaska Native and Black or African American" ~ 'black_aiain',
    .data$LNTITLE == "Remainder of Two or More Race Responses" ~ 'two',
    .data$LNTITLE == "Hispanic or Latino" ~ 'hisp',
    TRUE ~ 'uh_oh'
  ))

}

clean_cvap_names <- function(data) {
  noms <- names(data)
  noms <- noms %>%
    stringr::str_remove('_EST') %>%
    stringr::str_to_lower()
  noms[noms == 'geoid'] <- 'GEOID'
  names(data) <- noms

  data
}
