#' A version of [janitor::clean_names()] that also cleans dplyr groups
#'
#' @param data A dataframe
#'
#' @seealso [janitor::clean_names()]
#'
#' @return A dataframe
#' @export
#'
#' @examples
#' library(dplyr)
#'
#' clean_names_and_groups(group_by(tibble(x.x = 1), x.x))
#'
#' # Cleans names but not gruops
#' janitor::clean_names(group_by(tibble(x.x = 1), x.x))
clean_names_and_groups <- function(data) {
  clean_groups(janitor::clean_names(data))
}

#' Revert the effect of `clean_names_and_groups()``
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
  check_groups(data)
  dplyr::rename(data, !!!extract_unclean_names(data, unclean))
}

check_groups <- function(data) {
  g <- dplyr::group_vars(data)

  if (is.null(g)) {
    return(data)
  }

  unknown <- setdiff(g, names(data))
  if (length(unknown) > 0L) {
    stop(
      "All groups must be known column names.\n",
      "Known: ", paste0(names(data), collapse = ", "), "\n",
      "Unknown: ", paste0(unknown, collapse = ", "),
      call. = FALSE
    )
  }

  invisible(data)
}

clean_groups <- function(data) {
  g <- dplyr::group_vars(data)
  dplyr::grouped_df(data, vars = janitor::make_clean_names(g))
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
