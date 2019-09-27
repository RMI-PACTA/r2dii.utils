#' Create paths to specific 2dii directories, depending on a configuration file
#'
#' The output of this functions depends on the configuration file.
#'
#' @inheritDotParams fs::path_wd
#'
#' @seealso Replaces `dataprep.SetPaths()`.
#'
#' @return A character string.
#'
#' @family functions to output paths depending on a configuration file
#' @seealso [USER.NAME]
#'
#' @export
#' @examples
#' MASTER.DATA.PATH()
#'
#' # The output of these functions depends on the configuration file you use
#' # Defaults to using a configuration file that comes with the package
#' FIN.DATA.PATH()
#'
#' # You may use your own configuration file via `options()`
#' path_to_your_config_file <- example_config("config-toy.yml")
#' old_options <- options(r2dii_config = path_to_your_config_file)
#' FIN.DATA.PATH()
#'
#' # Restore
#' options(old_options)
#'
#' # Back to default
#' FIN.DATA.PATH()
#'
MASTER.DATA.PATH <- function(...) {
  dbox_port_00("01_ProcessedData", "01_SectorMasters", ALD.TIMESTAMP(), ...)
}
#' @rdname MASTER.DATA.PATH
#' @export
FIN.DATA.PATH <- function(...) {
  dbox_port_00("02_FinancialData", FINANCIAL.TIMESTAMP(), ...)
}
#' @rdname MASTER.DATA.PATH
#' @export
#' @examples
#' CBMARKET.DATA.PATH()
CBMARKET.DATA.PATH <- function(...) {
  dbox_port_00("02_FinancialData", FINANCIAL.TIMESTAMP(), "CompanyLevel", ...)
}
#' @rdname MASTER.DATA.PATH
#' @export
#' @examples
#' DATA.STORE.PATH()
DATA.STORE.PATH <- function(...) {
  folder <- glue("{FINANCIAL.TIMESTAMP()}_export_{DATASTORE.TIMESTAMP()}")
  dbox_port_00("06_DataStore", folder, ...)
}
#' @rdname MASTER.DATA.PATH
#' @export
#' @examples
#' ANALYSIS.INPUTS.PATH()
ANALYSIS.INPUTS.PATH <- function(...) {
  folder <- glue("{FINANCIAL.TIMESTAMP()}_{DATAPREP.TIMESTAMP()}")
  dbox_port_00("07_AnalysisInputs", folder, ...)
}



#' Create paths to specific 2dii directories
#'
#' @inheritParams fs::path_wd
#'
#' @seealso Replaces `dataprep.SetPaths()`.
#'
#' @return A character string.
#'
#' @family functions to output 2dii paths
#' @seealso [MASTER.DATA.PATH]
#'
#' @export
#'
#' @examples
#' fs::path_file(fs::path_home())
#' # Shortcut
#' USER.NAME()
#'
USER.NAME <- function() fs::path_file(fs::path_home())

#' @rdname USER.NAME
#' @export
#' @examples
#' DROPBOX.PATH()
DROPBOX.PATH <- function(...) {
  path_dropbox_2dii(...)
}

#' @rdname USER.NAME
#' @export
#' @examples
#' GIT.PATH()
GIT.PATH <- function(...) {
  out <- DROPBOX.PATH(
    glue("2{degrees()} Investing Team"), "People", USER.NAME(), "GitHub",
    ...
  )

  warn_if_dir_does_not_exist(out)
  out
}

warn_if_dir_does_not_exist <- function(x) {
  if (!fs::dir_exists(x)) {
    warn(glue("The output path doesn't exist. Do you need to create it?"))
  }

  invisible(x)
}

#' @rdname USER.NAME
#' @export
#' @examples
#' WEBTOOL.PATH()
WEBTOOL.PATH <- function(...) GIT.PATH("Webtool-v2", ...)
#' @rdname USER.NAME
#' @export
#' @examples
#' COMPANY.PATH()
COMPANY.PATH <- function(...) GIT.PATH("CompanyAnalysis", ...)

#' @rdname USER.NAME
#' @export
#' @examples
#' dbox_port_00("a", "directory")
dbox_port_00 <- function(...) DROPBOX.PATH("PortCheck", "00_Data", ...)
#' @rdname USER.NAME
#' @export
#' @examples
#' SCENARIO.DATA.PATH()
SCENARIO.DATA.PATH <- function(...) {
  dbox_port_00("01_ProcessedData", "03_ScenarioData", ...)
}

#' @rdname USER.NAME
#' @export
#' @examples
#' dbox_port2_10proj("a", "directory")
dbox_port2_10proj <- function(...) {
  DROPBOX.PATH("PortCheck_v2", "10_Projects", ...)
}
#' @rdname USER.NAME
#' @export
#' @examples
#' EQMARKET.DATA.PATH()
EQMARKET.DATA.PATH <- function(...) {
  dbox_port2_10proj("0_MarketPortfolios", "21_EQMarketSize_Inputs", ...)
}
#' @rdname USER.NAME
#' @export
#' @examples
#' MARKET.DATA.PATH()
MARKET.DATA.PATH <- function(...) {
  dbox_port2_10proj("0_MarketPortfolios", "20_Raw_Inputs", ...)
}
#' @rdname USER.NAME
#' @export
#' @examples
#' INDEX.DATA.PATH()
INDEX.DATA.PATH <- function(...) {
  dbox_port2_10proj("0_Indices", "20_Raw_Inputs", ...)
}
#' @rdname USER.NAME
#' @export
#' @examples
#' INDEX.RESULTS.DATA.PATH()
INDEX.RESULTS.DATA.PATH <- function(...) {
  dbox_port2_10proj("0_Indices", "40_Results", ...)
}
#' @rdname USER.NAME
#' @export
#' @examples
#' FUND.DATA.PATH()
FUND.DATA.PATH <- function(...) {
  dbox_port2_10proj("0_FundPortfolios", "20_Raw_Inputs", ...)
}
