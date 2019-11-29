test_that("path_dropbox_2dii output is as expected", {
  expect_equal(
    fs::path_file(path_dropbox_2dii()),
    as.character(glue("Dropbox (2{degrees()} Investing)"))
  )
})

test_that("path_dropbox_2dii output is an fs path", {
  expect_is(path_dropbox_2dii(), "fs_path")
})

test_that("path_dropbox_2dii outputs on object of correct class", {
  expect_is(path_dropbox_2dii(), "fs_path")
})

test_that("path_dropbox_2dii outputs a path to an existing directory", {
  skip_if_not(dropbox_exists())
  expect_true(fs::dir_exists(path_dropbox_2dii()))
})

test_that("DROPBOX.PATH is deprecated", {
  withr::local_options(list(lifecycle_verbosity = "warning"))
  expect_warning(DROPBOX.PATH(), class = "lifecycle_warning_deprecated")
})

test_that("DROPBOX.PATH output is as expected", {
  expect_equal(
    # Wanrs that it's deprecated
    suppressWarnings(DROPBOX.PATH()),
    path_dropbox_2dii()
  )
})

test_that("r2dii_dropbox_path works with a custom Dropbox folder", {
  out <- withr::with_options(
    list(r2dii_dropbox = "custom dropbox"),
    path_dropbox_2dii("a", "path")
  )

  pattern <- fs::path("custom dropbox", "a", "path")
  expect_true(grepl(pattern, out))
})

test_that("find_dropbox_2dii returns a path to an existing path", {
  skip_if_not(dropbox_exists())

  expect_true(fs::dir_exists(find_dropbox_2dii()))
})

test_that("find_dropbox_2dii errros if returned path doesn't exist", {
  withr::local_options(list(r2dii_dropbox = "Wrong Dropbox"))

  expect_error(find_dropbox_2dii(), "Dropbox.*must exist")
})

test_that("find_dropbox_2dii errros if returned path doesn't exist", {
  skip_if_not(dropbox_exists())

  expect_warning(
    find_dropbox_2dii("path", "to", "nowhere"),
    "directory doesn't exist"
  )
})
