test_that("get_param(<field>)(<file>) outputs a value from a config <file>", {
  config_file <- glue::glue("
    default:
      a_field: a_value
  ")
  config_path <- tempfile()
  readr::write_lines(config_file, config_path)

  expect_equal(get_param("a_field")(), NULL)
  expect_equal(get_param("a_field")(config_path), "a_value")
})

test_that("get_param returns value if param is not NULL", {
  path_config <- example_config("config-toy.yml")

  get_1 <- get_param("Expect", "param_1", if_null = stop)
  expect_equal(get_1(path_config), 1)
  expect_equal(get_1(path_config), 1)
  expect_is(get_1(path_config), "integer")

  get_a <- get_param("Expect", "param_a")
  expect_equal(get_a(path_config), "a")

  get_true <- get_param("Expect", "param_true")
  expect_true(get_true(path_config))

  get_false <- get_param("Expect", "param_false")
  expect_false(get_false(path_config))
})

test_that("get_param with `if_null = stop` throws an error", {
  path_config <- example_config("config-toy.yml")

  get_null <- get_param("Expect", "param_null", if_null = stop)
  expect_error(
    get_null(path_config),
    "must be not `NULL`"
  )
})

test_that("get_param with `if_null = NULL` returns null", {
  path_config <- example_config("config-toy.yml")

  get_null <- get_param("Expect", "param_null", if_null = NULL)
  expect_null(get_null(path_config))
})

test_that("get_param with `if_null = <value>` returns <value>", {
  path_config <- example_config("config-toy.yml")

  get_null_set_1 <- get_param("Expect", "param_null", if_null = 1)
  expect_equal(
    expect_warning(get_null_set_1(path_config), "param_null.*is undefined"),
    1
  )
})

test_that("FIN.DATA.PATH uses `r2dii.dataraw_config` option", {
  config <- example_config("config-toy.yml")
  withr::local_options(list(r2dii.dataraw_config = config))

  fin <- fs::path_file(r2dii.dataraw::FIN.DATA.PATH())
  expect_equal(fin, "2018Q3")
})

test_that("FINANCIAL.TIMESTAMP uses `r2dii.dataraw_config` option", {
  config <- example_config("config-toy.yml")
  withr::local_options(list(r2dii.dataraw_config = config))

  expect_equal(FINANCIAL.TIMESTAMP(), "2018Q3")
  expect_equal(ALD.TIMESTAMP(), 3333L)
})

test_that("FINANCIAL.TIMESTAMP with defaults outputs 2018Q4", {
  expect_equal(FINANCIAL.TIMESTAMP(), "2018Q4")
})
