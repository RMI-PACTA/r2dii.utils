#' Create a configuration file
#'
#' @param ... String(s) to pass to the `...` argument of [glue::glue()].
#' @param path String giving the path where to save the configuration file.
#'
#' @family functions to deal with configuration files
#' @seealso [FINANCIAL.TIMESTAMP]
#'
#' @return Invisible `path`.
#' @export
#'
#' @examples
#' out <- create_config("
#'   default:
#'     field: value
#' ")
#' out
#'
#' show_config(out)
create_config <- function(..., path = fs::file_temp("config-", ext = ".yml")) {
  ellipsis::check_dots_used()

  readr::write_lines(glue::glue(...), path = path)
  usethis::ui_done("Saved to {usethis::ui_path(path)}.")

  invisible(path)
}
