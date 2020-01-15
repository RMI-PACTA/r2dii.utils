library(dplyr)

test_that("unclean_names reverses the effect of janitor::clean_names", {
  data <- tibble(x.x = 1, y = 1, z.z = 1)
  expect_equal(
    unclean_names(janitor::clean_names(data), data),
    data
  )
})

test_that("unclean_names works with more complex clean data", {
  dirty <- tibble(x.x = 1, y = 1, z.z = 1)
  clean <- janitor::clean_names(dirty) %>%
    rename(z = z_z, y.y = y) %>%
    mutate(new = 1)

  expect_equal(
    unclean_names(clean, dirty),
    tibble(
      x.x = 1, # restored from dirty
      y.y = 1, # shouldn't change because it didn't exist in dirty
      z = 1, # shouldn't change because it didn't exist in dirty
      new = 1, # shouldn't change because it didn't exist in dirty
    )
  )
})
