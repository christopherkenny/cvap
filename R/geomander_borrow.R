estimate_down <- function(wts, value, group) {
  if (missing(wts)) {
    wts <- 1
  }
  if (missing(value)) {
    value <- 1
  }

  tb <- dplyr::tibble(wts = wts, group = group) |>
    dplyr::group_by(.data$group) |>
    dplyr::mutate(GTot = sum(.data$wts)) |>
    dplyr::ungroup() |>
    dplyr::mutate(wts = dplyr::if_else(.data$GTot == 0, 1, .data$wts)) |>
    dplyr::group_by(.data$group) |>
    dplyr::mutate(GTot = sum(.data$wts)) |>
    dplyr::ungroup() |>
    dplyr::mutate(cont = .data$wts / .data$GTot)

  tb2 <- dplyr::tibble(group = seq_along(value), value = value)

  tb <- tb |>
    dplyr::left_join(tb2, by = 'group') |>
    dplyr::mutate(out = .data$cont * .data$value)

  tb <- tb |>
    dplyr::mutate(out = ifelse(is.na(.data$out), 0, .data$out))

  tb$out
}
