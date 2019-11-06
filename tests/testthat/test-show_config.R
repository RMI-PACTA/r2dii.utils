test_that("show_config shows the correct stuff", {
  config_file <- glue::glue("
    default:
      a_field: a_value
  ")
  config_path <- tempfile()
  readr::write_lines(config_file, config_path)

  expect_output(show_config(config_path), config_file)
})

test_that("get_config is sensitive to global options", {
  default_config <- suppressWarnings(default_config())
  out <- withr::with_options(list(r2dii_config = default_config), {
    get_config()
  })
  expect_equal(out, default_config)

  config <- config <- example_config("config-toy.yml")
  out <- withr::with_options(list(r2dii_config = config), {
    get_config()
  })
  expect_equal(out, example_config("config-toy.yml"))
})

test_that("example_config returns a path ending in config-toy.yml", {
  expect_equal(
    fs::path_file(example_config("config-toy.yml")),
    "config-toy.yml"
  )
})
