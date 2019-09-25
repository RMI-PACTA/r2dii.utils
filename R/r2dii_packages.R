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
  sort(c("r2dii.dataprep", "r2dii.dataraw", "r2dii.utils"))
}
