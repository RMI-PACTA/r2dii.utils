#' Easily access directories in your local copy of 2dii's Dropbox folder
#'
#' Nesting your projects in 2dii's Dropbox folder is a bad idea. The path to
#' 2dii's Dropbox folder contains a space and a symbol which -- among other
#' problems -- may brake RStudio's Git pane
#' ([example](https://github.com/2DegreesInvesting/resources/issues/51)). This
#' function allows you to access files located in a problematic local address
#' such as `C:/Users/You/Dropbox (2{degrees} Investing)/datasets/data.csv` from
#' a local project located in a sane address such as
#' `C:/Users/You/git/project/`.
#'
#' @param ... Character vectors, if any values are `NA`, the result will also be
#'   `NA`.
#'
#' @seealso [degrees()].
#' @family functions to output 2dii paths
#'
#' @return A character string.
#' @export
#'
#' @examples
#' path_dropbox_2dii()
#'
#' path_dropbox_2dii("path/to/somewhere")
path_dropbox_2dii <- function(...) {
  fs::path_home(glue("Dropbox (2{degrees()} Investing)"), ...)
}
