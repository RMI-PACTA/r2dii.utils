#' Paths to examples in any package
#'
#' @param path Name of file.
#' @param package Character string giving the name of a single package. `NULL`
#'   defaults to the current
#'
#' @family miscellaneous utility functions
#'
#' @return
#' * `path_example()`: A path to a single example.
#' * `path_examples()`: A character vector of all built-in examples.
#'
#' @export
#'
#' @examples
#' path_examples("readr")
#' path_example("mtcars.csv", package = "readr")
path_examples <- function(package) {
  dir(system.file("extdata", package = package))
}

#' @rdname path_examples
#' @export
path_example <- function(path, package) {
  system.file("extdata", path, package = package, mustWork = TRUE)
}
