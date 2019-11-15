test_that("path_examples outputs a vector with many paths", {
  expect_is(path_examples("readr"), "character")
  expect_true(length(path_examples("readr")) > 1L)
})

test_that("path_example errors with missing arguments", {
  expect_error(path_examples(), "package.*is missing")
})

test_that("path_example outputs a single path", {
  expect_length(path_example("mtcars.csv", package = "readr"), 1L)
})

test_that("path_example errors with missing arguments", {
  expect_error(path_example(), "package.*is missing")
  expect_error(path_example(package = "readr"), "path.*is missing")
})
