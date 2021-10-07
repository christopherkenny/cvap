process_cvap_file <- function(path, out_dir) {
  raw <- readr::read_csv(file = path)

  geography <- fs::path_file(fs::path_ext_remove(path))

  vals <- c('cvap', 'cvap_moe', 'cit', 'cit_moe')
  if (!'CIT_EST' %in% names(raw)) {
    vals <- vals[-3:-4]
  }

  wide <- raw %>%
    dplyr::mutate(GEOID = stringr::str_sub(GEOID, 8)) %>%
    clean_LNTITLE() %>%
    clean_cvap_names() %>%
    dplyr::filter(lntitle != 'not_hisp') %>%
    tidyr::pivot_wider(id_cols = c(GEOID, geoname),
                     names_from = lntitle,
                     values_from = dplyr::all_of(vals)) %>%
    dplyr::rename_with(.fn = function(x){stringr::str_sub(x, end = -2)},
                       .cols = dplyr::ends_with('_'))

  if (nrow(wide) > 1){
    wide <- wide %>% dplyr::mutate(state = stringr::str_sub(GEOID, 1, 2))
  }

  wide
}

