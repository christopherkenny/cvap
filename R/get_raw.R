#' Get Raw Citizen Voting Age Population Files
#'
#' @param url URL to CVAP zip to download. Use `cvap_census_url()`.
#' @param out_dir Directory to unzip to. Defaults to temp directory.
#'
#' @return string, path where the data is saved
#' @export
#'
#' @concept raw
#' @examples
#' \donttest{
#' # takes 10-20 seconds
#' path <- cvap_get_raw(cvap_census_url())
#' }
#'
cvap_get_raw <- function(url, out_dir) {
  path <- fs::file_temp(pattern = 'zip')
  utils::download.file(url = url, destfile = path)

  if (missing(out_dir)) {
    out_dir <- tempdir()
  }

  utils::unzip(path, exdir = out_dir)

  out_dir
}
