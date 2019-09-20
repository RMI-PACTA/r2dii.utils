#' Build r2dii's site based on documentation from core packages.
#'
#' @return `NULL`. This function is called for its side effects.
#'
#' @examples
#' build_r2dii_site()
#' @noRd
r2dii_build_site <- function() {
  fs::dir_copy("../r2dii.dataraw/man", "man")
  pkgdown::build_site(examples = FALSE)
  fs::dir_delete("man")

  invisible(NULL)
}
