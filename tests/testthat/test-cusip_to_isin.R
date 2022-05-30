# Test with an unvalid cusip
test_that("warning message if cusip not 9-digit", {
  bad_cusip <- data.frame(c("037833100", "38259P50"))
  expect_error(
    cusip_to_isin(bad_cusip,
    class = "cusip_wrong_format"))
  })


# Test that the calculation is correct
test_that("check_digit calculation is performed correctly on example", {

  cusip <- c("037833100", "02079K107")
  check_digit <- c(5, 9)
  expected <- data.frame(cusip, check_digit)
  result <- cusip_to_isin(data.frame(cusip))

  expect_equal(expected, result)

})