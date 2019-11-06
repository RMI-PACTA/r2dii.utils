
<!-- README.md is generated from README.Rmd. Please edit that file -->

# <img src="https://i.imgur.com/3jITMq8.png" align="right" height=40 /> General utility tools

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/2DegreesInvesting/r2dii.utils.svg?branch=master)](https://travis-ci.org/2DegreesInvesting/r2dii.utils)
<!-- badges: end -->

The goal of r2dii.utils is to provide general utility tools.

## Installation

Install the development version of r2dii.utils with something like this:

``` r
# install.packages("devtools")
devtools::install_github("2DegreesInvesting/r2dii.utils")
```

## Example

``` r
library(r2dii.utils)
```

### Configuration

Most analysis may start by setting a configuration file globally via
`options()`.

``` r
options(r2dii_config = "path/to/your/configuration/file.yml")
get_config()
#> [1] "path/to/your/configuration/file.yml"
```

If you don’t set a global configuration file, we default to using a toy
configuration file with a warning.

``` r
options(r2dii_config = NULL)
get_config()
#> Warning: Using a toy configuration file.
#> You may use your configuration file with `options(r2dii_config = 'path/to/config.yml')`
#> [1] "C:/Users/Mauro/Documents/R/win-library/3.6/r2dii.utils/config_demo.yml"
```

I want to avoid that warning throughout this example, so I set the
default configuration file explicitly.

``` r
options(r2dii_config = suppressWarnings(default_config()))
# No longer throws a warning
get_config()
#> [1] "C:/Users/Mauro/Documents/R/win-library/3.6/r2dii.utils/config_demo.yml"
```

### Paths

A family of functions help you to create convenient paths pointing to
directories inside 2dii’s dropbox-folder. The most general is
`path_dropbox_2dii()`.

``` r
path_dropbox_2dii("path", "to", "a", "file.csv")
#> C:/Users/Mauro/Dropbox (2° Investing)/path/to/a/file.csv
```

A family of functions help you to get specific parameters from the
configuration file.

``` r
START.YEAR()
#> [1] 2019
```

Other functions are miscellaneous utilities.

``` r
degrees()
#> [1] "°"

glue::glue("2 {degrees()} Investing Initiative")
#> 2 ° Investing Initiative
```

[Get started](https://2degreesinvesting.github.io/r2dii/#examples)
