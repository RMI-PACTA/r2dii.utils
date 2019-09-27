test_that("path_dropbox_2dii output is as expected", {
  expect_equal(
    fs::path_file(path_dropbox_2dii()),
    as.character(glue("Dropbox (2{degrees()} Investing)"))
  )
})

test_that("path_dropbox_2dii output is an fs path", {
  expect_is(path_dropbox_2dii(), "fs_path")
})

