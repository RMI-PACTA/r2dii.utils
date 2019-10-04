#' Does this computer have a local copy of 2dii's dropbox folder?
#'
#' @family miscellaneous utility functions
#'
#' @return Logical.
#'
#' @export
#' @examples
#' dropbox_exists()
dropbox_exists <- function() {
  fs::dir_exists(path_dropbox_2dii())
}
