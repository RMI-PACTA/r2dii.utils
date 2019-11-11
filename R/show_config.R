#' Show a configuration file
#'
#' @param path A string giving the path to a configuration file. `NULL` defaults
#'   to [get_config()].
#' @param ... Other arguments passed to [readr::read_lines()], e.g. `n_max`.
#'
#' @return Prints to the console the configuration file.
#' @export
#'
#' @family functions to deal with configuration files
#' @seealso [FINANCIAL.TIMESTAMP]
#'
#' @examples
#' # A configuration file stored in the package
#' path <- default_config()
#' show_config(path, n_max = 10)
#'
#' # Create a new configuration file to show a more general case
#' config_file <- glue::glue("
#'   default:
#'     a_field: a_value
#' ")
#' config_path <- tempfile()
#' readr::write_lines(config_file, config_path)
#'
#' show_config(config_path)
show_config <- function(path = get_config(), ...) {
  cat(readr::read_lines(path, ...), sep = "\n")
}

#' Edit the default configuration file
#'
#' @inheritParams show_config
#'
#' @return Invisible `default_config()`.
#' @export
#'
#' @family functions to deal with configuration files
#' @seealso [FINANCIAL.TIMESTAMP]
#'
#' @examples
#' # Use only interactively
#' # edit_config(example_config("config-toy.yml"))
#'
#' # Now you should see something like this:
#' show_config(example_config("config-toy.yml"))
edit_config <- function(path = get_config()) {
  usethis::edit_file(path)
}

#' Create a path pointing to a configuration file
#'
#' * `default_config()` returns a the path to the default configuration file
#' that comes with this package.
#' * `get_config()` returns a the path to the default configuration file unless
#' you set a new path via `options(r2dii_config = "a/path/to/your/config.yml")`.
#' * `example_config(<path>)` returns a path to a configuration file for
#' examples and tests; `example_config()` returns a character string with
#' available configuration files for examples.
#'
#' @param path Character string giving the name of an available file. See
#'   available files with `example_config()`.
#'
#' @return Character string.
#' @export
#'
#' @family functions to deal with configuration files
#' @seealso [FINANCIAL.TIMESTAMP]
#'
#' @examples
#' default_config()
#'
#' example_config()
#' example_config("config-toy.yml")
default_config <- function() {
  warn_using_toy_config()
  example_config("config_demo.yml")
}

#' @rdname default_config
#' @export
example_config <- function(path = NULL) {
  if (is.null(path)) {
    fs::dir_ls(system.file(package = "r2dii.utils"), glob = "*.yml")
  } else {
    system.file(path, package = "r2dii.utils", mustWork = TRUE)
  }
}

#' @rdname default_config
#' @export
#' @examples
#' getOption("r2dii_config")
#' get_config()
#'
#' restore <- options(r2dii_config = "path/to/your/config.yml")
#'
#' getOption("r2dii_config")
#' get_config()
#'
#' options(restore)
#' getOption("r2dii_config")
#' get_config()
get_config <- function() {
  getOption("r2dii_config") %||% default_config()
}

warn_using_toy_config <- function() {
  hint <- ui_code("options(r2dii_config = 'path/to/config.yml')")
  warn(
    glue(
      "Using a toy configuration file.
      You may use your configuration file with {hint}"
    )
  )
}
