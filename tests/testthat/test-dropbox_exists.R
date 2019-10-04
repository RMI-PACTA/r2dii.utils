is_mauro_pc <- function() {
  identical(Sys.getenv("USERNAME"), "Mauro")
}

test_that("dropbox_exists returs true on Mauro's computer", {
  skip_if_not(is_mauro_pc(), "Not in Mauro's PC")

  expect_true(dropbox_exists())
})
