#' Return a vector giving the name of r2dii packages
#'
#' @return String. A vector giving the name of r2dii packages
#' @export
#'
#' @family miscellaneous utility functions
#'
#' @examples
#' r2dii_packages()
r2dii_packages <- function() {
  pkgs <- utils::packageDescription("r2dii", fields = "Depends", drop = T)
  pkgs <- strsplit(pkgs, ",")[[1]]
  vapply(pkgs, function(x) sub("\n", "", x), character(1), USE.NAMES = FALSE)
}
