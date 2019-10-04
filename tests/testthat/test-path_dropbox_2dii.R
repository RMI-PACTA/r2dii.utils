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

