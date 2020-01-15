#' Revert the effect of [janitor::clean_names()]
#'
#' @param data A dataframe
#' @param unclean A dataframe, commonly a version of `data` before running
#'   `janitor::clean_names(data)`.
#'
#' @export
#' @examples
#' library(dplyr)
#'
#' dirty <- tibble(x.x = 1, y = 1)
#' names(dirty)
#'
#' clean <- janitor::clean_names(dirty)
#' names(clean)
#'
#' names(unclean_names(clean, dirty))
#'
#' # Cases where data doesn't change because no name matches unclean names
#' # exactly -- after applying janitor::clean_names()
#'
#' unclean <- tibble(y = 1)
#' data <- tibble(y.y = 1)
#' data %>% unclean_names(unclean)
#'
#' unclean <- tibble(y.y = 1)
#' data <- tibble(y = 1)
#' data %>% unclean_names(unclean)
unclean_names <- function(data, unclean) {
  dplyr::rename(data, !!!extract_unclean_names(data, unclean))
}

extract_unclean_names <- function(data, unclean) {
  names(unclean) %>%
    rlang::set_names() %>%
    purrr::map(extract_clean_names_from, data) %>%
    purrr::keep(~ length(.x) > 0L)
}

extract_clean_names_from <- function(x, data) {
  grep(anchor(janitor::make_clean_names(x)), names(data), value = TRUE)
}

anchor <- function(x) {
  paste0("^", x, "$")
}
