#' Insert the symbol for degrees
#'
#' @return A string.
#' @export
#'
#' @family miscellaneous utility functions
#'
#' @examples
#' degrees()
#' glue::glue("2{degrees()} Investing Initiative")
degrees <- function() {
  "\u00B0"
}
