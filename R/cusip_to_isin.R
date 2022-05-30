cusip_to_isin <- function(cusip_df) {
  
  # Check input
  colnames(cusip_df) <- "cusip"
  if (any(nchar(cusip_df$cusip) != 9)) {
    abort("The input is not a 9-digit alphanumeric string",
            class = "cusip_wrong_format")
  } 
  
  # Append US to beginning of the string 
  cusip_df_modified <- sapply(cusip_df, function(x) paste("US", x, sep=""))
  
  # Convert character to digits
  letters_to_numeric <- data.frame(LETTERS, NUMBERS = as.character(10:35))
  
  replace_letters <-  function(x){
    for (j in 1:26) {
      x <- str_replace_all(x, letters_to_numeric$LETTERS[j], letters_to_numeric$NUMBERS[j])
    }
    return(x)
  }
  
  cusip_df_modified <- cusip_df_modified %>% apply(1, replace_letters)
  cusip_df_modified <- cusip_df_modified %>% data.frame()
  number_of_digits <- sapply(cusip_df_modified, function(x) nchar(x))
  cusip_df_modified <- cbind(cusip = cusip_df_modified, number_digits = number_of_digits)
  colnames(cusip_df_modified) <- c("cusip", "number_digits")
  
  # Split up even and odd digits
  odd <- data.frame(matrix(ncol = max(nchar(cusip_df_modified$cusip)), nrow = nrow(cusip_df_modified)))
  even <- data.frame(matrix(ncol = max(nchar(cusip_df_modified$cusip)), nrow = nrow(cusip_df_modified)))
  
  for (i in 1:max(nchar(cusip_df_modified$cusip))) {
  odd[i] <- data.frame(substr(cusip_df_modified$cusip, i*2-1, i*2-1))
  even[i] <- data.frame(substr(cusip_df_modified$cusip, i*2, i*2))
  }
  
  odd_numeric <- data.frame(sapply(odd, function(x) as.numeric(x)))
  even_numeric <- data.frame(sapply(even, function(x) as.numeric(x)))

  # Identify the group with the rightmost digit and multiply by 2
  right_most <- data.frame(matrix(ncol = max(nchar(cusip_df_modified$cusip)), nrow = nrow(cusip_df_modified)))
  not_right_most <- data.frame(matrix(ncol = max(nchar(cusip_df_modified$cusip)), nrow = nrow(cusip_df_modified)))
  
  for (i in 1:nrow(cusip_df_modified)) {
    if (cusip_df_modified$number_digits[i]%%2 == 0) {
      right_most[i,] <- data.frame(sapply(even_numeric, function(x) 2*x))[i,]
      not_right_most[i,] <- odd_numeric[i,]
      }
    else {
      right_most[i,] <- data.frame(sapply(odd_numeric, function(x) 2*x))[i,]
      not_right_most[i,] <- even_numeric[i,]
    }
  }
  
  # Glue and separate the multiplied digits 
  paste_without_na <- function(x) {
    x <- as.numeric(paste(x[!is.na(x)],collapse=""))
    return(x)
  }
  
  right_most <- data.frame(apply(right_most, 1, paste_without_na))
  not_right_most <- data.frame(apply(not_right_most, 1, paste_without_na))
  
  
  # Function to sum all digits
  sum_digits <- function(n) {
    s = 0
    while (n > 0) {
      r = n %% 10
      s = s + r
      n = n %/% 10
    }
    return(s)
  }
  
  right_most <- data.frame(apply(right_most, 1, sum_digits))
  not_right_most <- data.frame(apply(not_right_most, 1, sum_digits))
 
  merged_even_odd <- cbind(right_most, not_right_most)
  
  merged_even_odd$sum = apply(merged_even_odd, 1, sum)
    
  # Perform modulus calculation
  merged_even_odd$check_digit = apply(merged_even_odd[3], 1, function(x) ((10-(x %% 10))%%10))

  # Return result
  cusip_check_digit <- cbind(cusip_df, check_digit = merged_even_odd$check_digit)
  return(cusip_check_digit)
  
}

