
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

path_dropbox_2dii("path", "to", "a", "file.csv")
#> C:/Users/Mauro/Dropbox (2° Investing)/path/to/a/file.csv

degrees()
#> [1] "°"

glue::glue("2{degrees()} Investing Initiative")
#> 2° Investing Initiative
```

[Get started](https://2degreesinvesting.github.io/r2dii/#examples)
