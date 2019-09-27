#' Easily access directories in your local copy of 2dii's Dropbox folder
#'
#'
#' This function creates cross-platform paths pointing to 2dii's Dropbox folder.
#'
#' Your projects may need data stored in 2dii's Dropbox folder. Sometimes it is
#' convenient to have your projects close to the data. But, in this case, it is
#' a bad idea because the path to 2dii's Dropbox folder has a problematic space
#' and symbol. (For example, [RStudio's Git pane may not
#' work](https://github.com/2DegreesInvesting/resources/issues/51).) Instead,
#' place your projects somewhere with a sane path, such as
#' `C:/Users/You/git/project/`, and access the data you need with
#' `path_dropbox_2dii()`.
#'
#' @param ... Character vectors, if any values are `NA`, the result will also be
#'   `NA`.
#'
#' @seealso [degrees()], [fs::path_home()].
#' @family functions to output 2dii paths
#'
#' @return A character string.
#' @export
#'
#' @examples
#' path_dropbox_2dii()
#'
#' path_dropbox_2dii("path", "to", "somewhere")
path_dropbox_2dii <- function(...) {
  fs::path_home(glue("Dropbox (2{degrees()} Investing)"), ...)
}
