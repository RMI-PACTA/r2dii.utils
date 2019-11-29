#' Easily access directories in your local copy of 2dii's Dropbox folder
#'
#' These functions create cross-platform paths pointing to 2dii's Dropbox
#' folder:
#' * `find_dropbox_2dii()` is user-oriented; it checks the output is an existing
#'   path.
#' * `path_dropbox_2dii()` is low-level, developer-oriented; it doesn't care
#'   if the output is not an existing path.
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
#' @section Setup for a custom Dropbox folder:
#' If the name of your 2dii Dropbox folder is different from the default,
#' you may add this to .Rprofile (see [usethis::edit_r_profile()]):
#'
#' ```
#' options(r2dii_dropbox = "The name of your custom dropbox folder goes here")
#' ````
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
#' # If it points to a nonexistent directory, path_dropbox_2dii() doesn't care
#' path_dropbox_2dii("path", "to", "nowhere")
#'
#' # find_dropbox_2dii() points to an existing directory or tells you if not:
#' # * It is a warning if the Dropbox folder exists but not the nested path
#' # * It is an error if the Dropbox folder does not exist:
#' restore <- options(r2dii_dropbox = "No Dropbox folder here")
#'
#' dropbox_exists()
#' try(
#'   find_dropbox_2dii("path", "to", "nowhere")
#' )
#'
#' options(restore)
find_dropbox_2dii <- function(...) {
  abort_if_not_dropbox_exists()
  out <- warn_if_not_dir_exists(path_dropbox_2dii(...))
  out
}

#' @rdname find_dropbox_2dii
#' @export
path_dropbox_2dii <- function(...) {
  custom <- getOption("r2dii_dropbox")
  default <- glue::glue("Dropbox (2{degrees()} Investing)")
  fs::path_home(custom %||% default, ...)
}

abort_if_not_dropbox_exists <- function() {
  if (!dropbox_exists()) {
    code_example <- usethis::ui_code(
      "options(r2dii_dropbox = 'Name of your 2dii Dropbox folder')"
    )

    abort(glue("
      2dii's Dropbox folder must exist, but this directory doesn't:
      {ui_path(path_dropbox_2dii())}
      Did you add your custom Dropbox folder in .Rprofile? Example:
      {code_example}
    "))
  }

  invisible()
}
