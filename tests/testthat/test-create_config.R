test_that("create_config creates the expected configuration file", {
  expect_output(
    out <- create_config("
     default:
       field: value
    "),
    "Saved"
  )

  expect_true(fs::file_exists(out))
  expect_equal(get_param("field")(out), "value")
})
