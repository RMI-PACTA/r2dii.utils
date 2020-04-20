#' Return a vector giving the name of r2dii packages
#'
#' @return String. A vector giving the name of r2dii packages
#' @export
#'
#' @family miscellaneous utility functions
#'
#' @examples
#' # The r2dii package must be installed
#' # See https://2degreesinvesting.github.io/r2dii/#installation
#' try(r2dii_packages())
r2dii_packages <- function() {
  # requireNamespace("r2dii") throws WARNING in R CMD check
  # Suggesting r2dii would create a circular dependency
  uses_r2dii <- any(grepl("^r2dii$", rownames(utils::installed.packages())))
  if (!uses_r2dii) {
    abort(
      glue(
        "The r2dii package must be installed. Install it from GitHub with:
         # install.packages('remotes')
         remotes::install_github('2degreesinvesting/r2dii')"
      )
    )
  }

  pkgs <- utils::packageDescription("r2dii", fields = "Depends", drop = TRUE)
  pkgs <- strsplit(pkgs, ",")[[1]]
  vapply(pkgs, function(x) sub("\n", "", x), character(1), USE.NAMES = FALSE)
}
