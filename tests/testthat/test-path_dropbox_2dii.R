test_that("path_drobox_2dii output is as expected", {
  expect_equal(
    fs::path_file(path_drobox_2dii()),
    as.character(glue("Dropbox (2{degrees()} Investing)"))
  )
})

test_that("path_drobox_2dii output is an fs path", {
  expect_is(path_drobox_2dii(), "fs_path")
})

