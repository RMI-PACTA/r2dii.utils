test_that("r2dii_packages returns the expected vector", {
  uses_r2dii <- any(grepl("^r2dii$", rownames(installed.packages())))
  if (!uses_r2dii) skip("r2dii is not installed.")

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
