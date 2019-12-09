test_that("create_config creates the expected configuration file", {
  out <- create_config("
   default:
     field: value
  ")

  expect_true(fs::file_exists(out))
  expect_equal(get_param("field")(out), "value")
})
