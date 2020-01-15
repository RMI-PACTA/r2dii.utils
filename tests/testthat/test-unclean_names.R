library(dplyr)

test_that("unclean_names reverses the effect of janitor::clean_names", {
  data <- tibble(x.x = 1, y = 1, z.z = 1)
  expect_equal(
    unclean_names(janitor::clean_names(data), data),
    data
  )
})

test_that("unclean_names works with more complex clean data", {
  unclean <- tibble(x.x = 1, y = 1, z.z = 1)
  clean <- janitor::clean_names(unclean) %>%
    rename(z = z_z, y.y = y) %>%
    mutate(new = 1)

  expect_equal(
    unclean_names(clean, unclean),
    tibble(
      x.x = 1, # restored from unclean
      # shouldn't change because it didn't exist in unclean
      y.y = 1,
      new = 1,
      z = 1,
    )
  )
})

test_that("unclean_names with grouped data returns unclean grouped data", {
  unclean <- dplyr::group_by(tibble(x.x = 1, y.y = 1, y = 1), x.x, y)
  data <- clean_names_and_groups(unclean)
  out <- unclean_names(data, unclean)
  expect_equal(names(out), names(unclean))
  expect_equal(dplyr::group_vars(out), dplyr::group_vars(unclean))
})

test_that("unclean_names errors if groups and names don't match", {
  unclean <- group_by(tibble(x.x = 1, y.y = 1, z.z = 1), x.x, y.y)

  # Leave data in bad shape
  clean <- janitor::clean_names(unclean)
  expect_named(clean, c("x_x", "y_y", "z_z"))
  expect_equal(dplyr::group_vars(clean), c("x.x", "y.y"))

  expect_error(
    unclean_names(clean, unclean),
    "must be known.*x.x"
  )
})

test_that("clean_names_and_groups cleans names and groups", {
  data <- tibble(x.x = 1, y = 1) %>%
    group_by(x.x)
  out <- clean_names_and_groups(data)
  expect_equal(names(out), c("x_x", "y"))
  expect_equal(dplyr::group_vars(out), "x_x")
})
