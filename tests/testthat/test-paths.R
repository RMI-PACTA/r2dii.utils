context("paths")

skip_if_not_in_mauro_pc <- function() {
  if (!stringr::str_detect(fs::path_home(), "Mauro")) {
    skip("Not in Mauro's PC")
  }
}

test_that("FIN.DATA.PATH is sensitive to config file set globally", {
  default <- withr::with_options(list(r2dii.dataraw_config = default_config()), {
    FIN.DATA.PATH()
  })
  config <- example_config("config-toy.yml")
  example <- withr::with_options(list(r2dii.dataraw_config = config), {
    FIN.DATA.PATH()
  })

  expect_false(identical(default, example))
})

test_that("DROPBOX.PATH output is as expected", {
  expect_equal(
    fs::path_file(DROPBOX.PATH()),
    as.character(glue("Dropbox (2{degrees()} Investing)"))
  )
})

test_that("USER.NAME outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_equal(USER.NAME(), "Mauro")
})

test_that("DROPBOX.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(DROPBOX.PATH()))
})

test_that("GIT.PATH warns if output doesn't exist", {
  expect_warning(GIT.PATH("bad-path"), "doesn't exist")
})

test_that("WEBTOOL.PATH warns if output doesn't exist", {
  expect_warning(WEBTOOL.PATH("bad-path"), "doesn't exist")
})

test_that("COMPANY.PATH warns if output doesn't exist", {
  expect_warning(COMPANY.PATH("bad-path"), "doesn't exist")
})

test_that("dbox_port_00 outputs a valid", {
  skip_if_not_in_mauro_pc()
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(dbox_port_00()))
})

test_that("SCENARIO.DATA.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(SCENARIO.DATA.PATH()))
})

test_that("MASTER.DATA.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(MASTER.DATA.PATH()))
})

test_that("FIN.DATA.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(FIN.DATA.PATH()))
})

test_that("CBMARKET.DATA.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(CBMARKET.DATA.PATH()))
})

test_that("DATA.STORE.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(DATA.STORE.PATH()))
})

test_that("ANALYSIS.INPUTS.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(ANALYSIS.INPUTS.PATH()))
})

test_that("dbox_port2_10proj outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(dbox_port2_10proj()))
})

test_that("EQMARKET.DATA.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(EQMARKET.DATA.PATH()))
})

test_that("MARKET.DATA.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(MARKET.DATA.PATH()))
})

test_that("INDEX.DATA.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(INDEX.DATA.PATH()))
})

test_that("INDEX.RESULTS.DATA.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(INDEX.RESULTS.DATA.PATH()))
})

test_that("FUND.DATA.PATH outputs a valid", {
  skip_if_not_in_mauro_pc()
  expect_true(fs::dir_exists(FUND.DATA.PATH()))
})

# Class -------------------------------------------------------------------

test_that("DROPBOX.PATH outputs on object of correct class", {
  expect_is(DROPBOX.PATH(), "fs_path")
})

test_that("GIT.PATH outputs on object of correct class", {
  expect_warning(
    expect_is(GIT.PATH("bad-path"), "fs_path")
  )
})

test_that("WEBTOOL.PATH outputs on object of correct class", {
  expect_warning(
    expect_is(WEBTOOL.PATH("bad-path"), "fs_path")
  )
})

test_that("COMPANY.PATH outputs on object of correct class", {
  expect_warning(
    expect_is(COMPANY.PATH("bad-path"), "fs_path")
  )
})

test_that("dbox_port_00 outputs on object of correct class", {
  expect_is(dbox_port_00(), "fs_path")
})

test_that("SCENARIO.DATA.PATH outputs on object of correct class", {
  expect_is(SCENARIO.DATA.PATH(), "fs_path")
})

test_that("MASTER.DATA.PATH outputs on object of correct class", {
  expect_is(MASTER.DATA.PATH(), "fs_path")
})

test_that("FIN.DATA.PATH outputs on object of correct class", {
  expect_is(FIN.DATA.PATH(), "fs_path")
})

test_that("CBMARKET.DATA.PATH outputs on object of correct class", {
  expect_is(CBMARKET.DATA.PATH(), "fs_path")
})

test_that("DATA.STORE.PATH outputs on object of correct class", {
  expect_is(DATA.STORE.PATH(), "fs_path")
})

test_that("ANALYSIS.INPUTS.PATH outputs on object of correct class", {
  expect_is(ANALYSIS.INPUTS.PATH(), "fs_path")
})

test_that("dbox_port2_10proj outputs on object of correct class", {
  expect_is(dbox_port2_10proj(), "fs_path")
})

test_that("EQMARKET.DATA.PATH outputs on object of correct class", {
  expect_is(EQMARKET.DATA.PATH(), "fs_path")
})

test_that("MARKET.DATA.PATH outputs on object of correct class", {
  expect_is(MARKET.DATA.PATH(), "fs_path")
})

test_that("INDEX.DATA.PATH outputs on object of correct class", {
  expect_is(INDEX.DATA.PATH(), "fs_path")
})

test_that("INDEX.RESULTS.DATA.PATH outputs on object of correct class", {
  expect_is(INDEX.RESULTS.DATA.PATH(), "fs_path")
})

test_that("FUND.DATA.PATH outputs on object of correct class", {
  expect_is(FUND.DATA.PATH(), "fs_path")
})
