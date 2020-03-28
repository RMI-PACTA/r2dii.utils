test_that("r2dii_packages returns the expected vector", {
  expect_equal(
    r2dii_packages(),
    sort(c(
      "r2dii.data",
      "r2dii.dataraw",
      "r2dii.match",
      "r2dii.utils"
    ))
  )
})
