estimate_down <- function(wts, value, group) {
  if (missing(wts)) {
    wts <- 1
  }
  if (missing(value)) {
    value <- 1
  }

  tb <- dplyr::tibble(wts = wts, group = group) %>%
    dplyr::group_by(group) %>%
    dplyr::mutate(GTot = sum(wts)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(wts = dplyr::if_else(GTot == 0, 1, wts)) %>%
    dplyr::group_by(group) %>%
    dplyr::mutate(GTot = sum(wts)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(cont = wts / GTot)

  tb2 <- dplyr::tibble(group = 1:length(value), value = value)

  tb <- tb %>%
    dplyr::left_join(tb2, by = 'group') %>%
    dplyr::mutate(out = cont * value)

  tb <- tb %>%
    dplyr::mutate(out = ifelse(is.na(out), 0, out))

  tb$out
}
