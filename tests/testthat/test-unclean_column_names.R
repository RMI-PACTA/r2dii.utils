library(dplyr)

test_that("unclean_column_names reverses the effect of janitor::clean_names", {
  data <- tibble(x.x = 1, y = 1, z.z = 1)
  expect_equal(
    unclean_column_names(janitor::clean_names(data), data),
    data
  )
})

test_that("unclean_column_names works with more complex clean data", {
  unclean <- tibble(x.x = 1, y = 1, z.z = 1)
  clean <- janitor::clean_names(unclean) %>%
    rename(z = z_z, y.y = y) %>%
    mutate(new = 1)

  expect_equal(
    unclean_column_names(clean, unclean),
    tibble(
      x.x = 1, # restored from unclean
      # shouldn't change because it didn't exist in unclean
      y.y = 1,
      new = 1,
      z = 1,
    )
  )
})

test_that("unclean_column_names reflects ungrouping of data", {
  unclean <- dplyr::group_by(tibble(x.x = 1, y.y = 1, z.z = 1), x.x, y.y)
  data <- unclean %>%
    clean_column_names() %>%
    ungroup()
  out <- unclean_column_names(data, unclean)
  expect_false(dplyr::is_grouped_df(out))
})

test_that("unclean_column_names reflects ungrouping of some but not all variables", {
  unclean <- dplyr::group_by(tibble(x.x = 1, y.y = 1, z.z = 1), x.x, y.y)
  data <- unclean %>%
    clean_column_names() %>%
    ungroup() %>%
    group_by(x_x)
  out <- unclean_column_names(data, unclean)
  expect_equal(dplyr::group_vars(out), "x.x")
})

test_that("unclean_column_names preserves groups behaviour of dplyr::select", {
  unclean <- dplyr::group_by(tibble(x.x = 1, y.y = 1, z.z = 1), x.x, y.y)
  data <- unclean %>%
    clean_column_names() %>%
    select(x_x)
  # select() re-adds dropped grouping variables to the left
  out <- unclean_column_names(data, unclean)
  expect_equal(names(out), c("y.y", "x.x"))
  expect_equal(dplyr::group_vars(out), dplyr::group_vars(unclean))
})

test_that("unclean_column_names with grouped data returns unclean grouped data", {
  unclean <- dplyr::group_by(tibble(x.x = 1, y.y = 1, y = 1), x.x, y)
  data <- clean_column_names(unclean)
  out <- unclean_column_names(data, unclean)
  expect_equal(names(out), names(unclean))
  expect_equal(dplyr::group_vars(out), dplyr::group_vars(unclean))
})

test_that("unclean_column_names errors if groups and names don't match", {
  unclean <- group_by(tibble(x.x = 1, y.y = 1, z.z = 1), x.x, y.y)

  # Leave data in bad shape
  clean <- janitor::clean_names(unclean)
  expect_named(clean, c("x_x", "y_y", "z_z"))
  expect_equal(dplyr::group_vars(clean), c("x.x", "y.y"))

  expect_error(
    unclean_column_names(clean, unclean),
    "must be known.*x.x"
  )
})

test_that("clean_column_names cleans names and groups", {
  data <- tibble(x.x = 1, y = 1) %>%
    group_by(x.x)
  out <- clean_column_names(data)
  expect_equal(names(out), c("x_x", "y"))
  expect_equal(dplyr::group_vars(out), "x_x")
})

test_that("unclean_column_names works with one group passes to an argument", {
  data <- tibble(x.x = rep(1:2, 2), y.y = x.x) %>%
    dplyr::arrange(x.x)

  expect <- structure(
    list(
      x.x = c(1L, 1L, 2L, 2L),
      y.y = c(1L, 1L, 2L, 2L),
      z = c(2L, 2L, 4L, 4L)
    ),
    class = c("grouped_df", "tbl_df", "tbl", "data.frame"),
    row.names = c(NA, -4L),
    groups = structure(
      list(y.y = 1:2, .rows = list(1:2, 3:4)),
      row.names = c(NA, -2L),
      class = c("tbl_df", "tbl", "data.frame"),
      .drop = TRUE
    )
  )



  # via .data[[by]]
  sum_y.y_by_one_chr <- function(data, by) {
    clean <- clean_column_names(data)
    by <- janitor::make_clean_names(by)

    out <- clean %>%
      group_by(.data[[by]]) %>%
      mutate(z = sum(y_y))

    unclean_column_names(out, data)
  }

  expect_error(actual <- sum_y.y_by_one_chr(data, by = "y.y"), NA)
  expect_equal(actual, expect)



  # via !!clean_quo
  sum_y.y_by_one_unquoted <- function(data, by) {
    clean <- clean_column_names(data)
    by <- clean_quo(enquo(by))

    out <- clean %>%
      group_by(!!by) %>%
      mutate(z = sum(y_y))

    unclean_column_names(out, data)
  }

  expect_error(actual <- sum_y.y_by_one_unquoted(data, by = y.y), NA)
  expect_equal(actual, expect)
})

test_that("unclean_column_names works with one group passes to ...", {
  data <- tibble(x.x = rep(1:2, 2), y.y = 1:4) %>%
    dplyr::arrange(x.x)

  # via clean_quos(enquos(...))
  sum_y.y_by_many <- function(data, ...) {
    clean <- clean_column_names(data)
    dots <- clean_quos(enquos(...))

    out <- clean %>%
      group_by(!!!dots) %>%
      mutate(z = sum(y_y))

    unclean_column_names(out, data)
  }

  out <- sum_y.y_by_many(data, x.x, y.y)
  expect_equal(out$z, out$y.y)
  expect_equal(group_vars(out), c("x.x", "y.y"))
})
