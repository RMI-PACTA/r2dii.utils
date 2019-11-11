#' Create functions to access configuration parameters
#'
#' This is a function factory to create functions which output the value of a
#' configuration parameter.
#'
#' @param ... Character string(s) giving a(the) field(s) in a configuration
#'   file.
#' @param if_null A value to fill an unset parameter, or the function `stop`.
#'
#' @export
#'
#' @return A function.
#'
#' @family functions to get specific 2dii configuration parameters
#' @seealso [FINANCIAL.TIMESTAMP]
#'
#' @examples
#' # get_param() is a function factory
#' # Create a `get_a_value()` function
#' get_a_value <- get_param("a_field")
#' class(get_a_value)
#'
#' # Create an example configuration file
#' config <- glue::glue("
#'     default:
#'       a_field: a_value
#'   ")
#' show_config(config)
#'
#' # Write the config file to a temporary file
#' path_to_config_file <- tempfile()
#' readr::write_lines(config, path_to_config_file)
#'
#' # Use `get_a_value()` to get a value from a field in the example config file
#' get_a_value(file = path_to_config_file)
#'
#' # Fails: The parameter 'bad' doesn't exist, so it is `NULL`
#' fails <- get_param("bad", if_null = stop)
#' try(fails())
#'
#' returns_null <- get_param("bad")
#' returns_null()
#'
#' returns_value_passed_to_if_null <- get_param("bad", if_null = 1)
#' returns_value_passed_to_if_null()
get_param <- function(..., if_null = NULL) {
  dots <- rlang::list2(...)
  function(file = get_config()) {
    pluck_param(dots, file = file, if_null = if_null)
  }
}

pluck_param <- function(x, file, if_null) {
  out <- purrr::pluck(config::get(file = file), !!! x)
  param <- ui_field(dplyr::last(unlist(x)))

  if (is.null(out) && identical(if_null, stop)) {
    abort(glue(
      "{param} must be not `NULL`.
      Please set {param} on the configuration (.yml) file."
    ))
  }

  if (is.null(out) && !is.null(if_null)) {
    param_ <- ui_field(param)
    warn(glue("On config.yml, {param} is undefined."))

    if_null_ <- ui_field(if_null)
    inform(glue("Setting {param_} to default value: {if_null_}."))
    out <- if_null
  }

  out
}

# if_null = stop ----------------------------------------------------------

#' Access parameters from a configuration file
#'
#' @param file A string giving a path to a configuration file.
#'
#' @family functions to get specific 2dii configuration parameters
#' @seealso [get_param]
#'
#' @export
#'
#' @return The value of the requested field. It's base time depends on the
#'   field.
#'
#' @examples
#' # Using the default configuration file that comes with the package
#' FINANCIAL.TIMESTAMP()
#'
#' # Using your configuration file
#' path_to_your_config_file <- example_config("config-toy.yml")
#'
#' # Passing your configuration file via the `file` argument
#' FINANCIAL.TIMESTAMP(file = path_to_your_config_file)
#'
#' # The default remains the same
#' FINANCIAL.TIMESTAMP()
#' ALD.TIMESTAMP()
#'
#' # Setting the path to your configuration file globally
#' old_options <- options(r2dii_config = path_to_your_config_file)
#' # The default configuration file has now changed
#' FINANCIAL.TIMESTAMP()
#' ALD.TIMESTAMP()
#'
#' # Reset options to cleanup
#' options(old_options)
#'
FINANCIAL.TIMESTAMP <- get_param(
  "TimeStamps", "FinancialData.Timestamp",
  if_null = stop
)

#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' timestamps_datastore_export()
timestamps_datastore_export <- get_param(
  "TimeStamps", "DataStore.Export",
  if_null = stop
)

#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' FINANCIAL.TIMESTAMP()
FINANCIAL.TIMESTAMP <- get_param(
  "TimeStamps", "FinancialData.Timestamp",
  if_null = stop
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
ALD.TIMESTAMP <- get_param(
  "TimeStamps", "ALD.Timestamp",
  if_null = stop
)

# if_null = NULL ----------------------------------------------------------

#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' DATASTORE.TIMESTAMP()
DATASTORE.TIMESTAMP <- get_param(
  "TimeStamps", "DataStore.Export",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' DATAPREP.TIMESTAMP()
DATAPREP.TIMESTAMP <- get_param(
  "TimeStamps", "DataPrep.Timestamp",
  if_null = stop
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' START.YEAR()
START.YEAR <- get_param(
  "AnalysisPeriod", "Years.Startyear",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' TIME.HORIZON()
TIME.HORIZON <- get_param(
  "AnalysisPeriod", "Years.Horizon",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' RISK.YEAR()
RISK.YEAR <- get_param(
  "AnalysisPeriod", "Years.Riskyear",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' ADDITIONAL.YEAR()
ADDITIONAL.YEAR <- get_param(
  "AnalysisPeriod", "Years.Additional",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' TECH.LIST()
TECH.LIST <- get_param(
  "Lists", "Technology.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' TECH.EXCLUDE()
TECH.EXCLUDE <- get_param(
  "Lists", "Technology.Exclusion.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' SECTOR.LIST()
SECTOR.LIST <- get_param(
  "Lists", "TechnologyRoadmap.Sector.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' OTHER.SECTOR.LIST()
OTHER.SECTOR.LIST <- get_param(
  "Lists", "CO2Intensity.Sector.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' SCENARIO.SOURCES.LIST()
SCENARIO.SOURCES.LIST <- get_param(
  "Lists", "Scenario.Sources.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' IEA.SCENARIO.LIST()
IEA.SCENARIO.LIST <- get_param(
  "Lists", "IEA.Scenarios.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' WEB.REGION.LIST()
WEB.REGION.LIST <- get_param(
  "Lists", "WebToolRegions",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' SCENARIO.GEOGRAPHIES.LIST()
SCENARIO.GEOGRAPHIES.LIST <- get_param(
  "Lists", "Scenario.Geography.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' EQUITY.MARKET.LIST()
EQUITY.MARKET.LIST <- get_param(
  "Lists", "Equity.Market.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' GLOBAL.AGGREGATE.SECTOR.LIST()
GLOBAL.AGGREGATE.SECTOR.LIST <- get_param(
  "Lists", "Global.Aggregate.Sector.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' GLOBAL.AGGREGATE.SCENARIO.SOURCES.LIST()
GLOBAL.AGGREGATE.SCENARIO.SOURCES.LIST <- get_param(
  "Lists", "Global.Aggregate.Scenario.Sources.List",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' CREATE.META.PORTFOLIO()
CREATE.META.PORTFOLIO <- get_param(
  "ComparisonBenchmarks", "CreateMetaPortfolio",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' META.INVESTOR.NAME()
META.INVESTOR.NAME <- get_param(
  "ComparisonBenchmarks", "MetaInvestorName",
  if_null = NULL
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' META.PORTFOLIO.NAME()
META.PORTFOLIO.NAME <- get_param(
  "ComparisonBenchmarks", "MetaPortfolioName",
  if_null = NULL
)

# if_null = <VALUE> -------------------------------------------------------

#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' HasBV()
HasBV <- get_param(
  "Methodology", "HasBookValue",
  if_null = FALSE
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' HasRISK()
HasRISK <- get_param(
  "Methodology", "HasRISK",
  if_null = TRUE
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' HasMAP()
HasMAP <- get_param(
  "Methodology", "HasMAP",
  if_null = TRUE
)
#' @rdname FINANCIAL.TIMESTAMP
#' @export
#' @examples
#' HasSB()
HasSB <- get_param(
  "Methodology", "HasSB",
  if_null = FALSE
)
