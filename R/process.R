#' Process Census CVAP File
#'
#' @param path path to csv file
#' @param year file year
#' @param out_dir directory to create files in
#' @param moe Boolean. Default is TRUE. Should margin of error be kept?
#' @param csv Boolean. Default is FALSE, which creates an rds file instead.
#'
#' @return tibble of cvap data
#' @export
#' @concept raw
#' @examples
#' path <- fs::path_package('cvap', 'extdata', 'County.csv')
#' cvap_process_file(path, year = 2019, out_dir = tempdir())
cvap_process_file <- function(path, year, out_dir, moe = TRUE, csv = FALSE) {
  raw <- readr::read_csv(file = path, lazy = FALSE) %>%
    suppressMessages()

  geography <- fs::path_file(fs::path_ext_remove(path))

  vals <- c('cvap', 'cvap_moe', 'cit', 'cit_moe')
  if (!'CIT_EST' %in% names(raw)) {
    vals <- vals[-3:-4]
  }

  wide <- raw %>%
    dplyr::rename_with(toupper) %>%
    dplyr::mutate(GEOID = stringr::str_sub(GEOID, 8)) %>%
    clean_LNTITLE() %>%
    clean_cvap_names() %>%
    dplyr::filter(lntitle != 'not_hisp') %>%
    tidyr::pivot_wider(
      id_cols = c(GEOID, geoname),
      names_from = lntitle,
      values_from = dplyr::all_of(vals)
    ) %>%
    dplyr::rename_with(
      .fn = function(x) {
        stringr::str_sub(x, end = -2)
      },
      .cols = dplyr::ends_with('_')
    )

  if (!moe) {
    wide <- wide %>% dplyr::select(-dplyr::ends_with('_moe'))
  }

  if (nrow(wide) > 1) {
    if (year >= 2020) {
      wide <- wide %>% dplyr::mutate(GEOID = stringr::str_sub(GEOID, 3))
    }
    wide <- wide %>% dplyr::mutate(state = stringr::str_sub(GEOID, 1, 2))

  } else {
    fs::dir_create(out_dir, 'nation')

    if (csv) {
      readr::write_csv(wide,
        file = fs::path(
          out_dir, 'nation',
          stringr::str_glue('us_{year}.csv')
        )
      )
    } else {
      readr::write_rds(wide,
        file = fs::path(
          out_dir, 'nation',
          stringr::str_glue('us_{year}.rds')
        ),
        compress = 'xz'
      )
    }
    return(wide)
  }

  wide_list <- wide %>%
    dplyr::group_by(state) %>%
    dplyr::group_split()

  lapply(cli::cli_progress_along(wide_list), function(i) {
    state <- censable::match_abb(wide_list[[i]]$state[1])
    fs::dir_create(out_dir, state)

    if (csv) {
      readr::write_csv(wide_list[[i]],
        file = fs::path(
          out_dir, state,
          stringr::str_glue('{tolower(geography)}_{year}.csv')
        )
      )
    } else {
      readr::write_rds(wide_list[[i]],
        file = fs::path(
          out_dir, state,
          stringr::str_glue('{tolower(geography)}_{year}.rds')
        ),
        compress = 'xz'
      )
    }
  })

  wide
}


#' Process Directory of CVAP Files
#'
#' @param dir Path to directory with the CVAP files
#' @param year file year
#' @param out_dir directory to create files in
#' @param moe Boolean. Default is TRUE. Should margin of error be kept?
#' @param csv Boolean. Default is FALSE, which creates an rds file instead.
#'
#' @return list of tibbles of cvap
#' @export
#' @concept raw
#' @examples
#' path <- fs::path_package('cvap', 'extdata')
#' cvap_process_dir(path, year = 2019, out_dir = tempdir())
cvap_process_dir <- function(dir, year, out_dir, moe = TRUE, csv = FALSE) {
  files <- fs::dir_ls(path = dir, glob = '*.csv')
  lapply(cli::cli_progress_along(files), function(i) {
    cvap_process_file(
      path = files[[i]], year = year, out_dir = out_dir,
      moe = moe, csv = csv
    )
  })
}
