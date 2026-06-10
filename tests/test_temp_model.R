library(testthat)
library(dplyr)

source(here::here("R/temperature_function.R"))

test_that("temperature_function calculates monthly means correctly", {

  test_data <- data.frame(
    date = c("2025-10-01", "2025-10-02", "2025-11-01", "2025-11-02"),
    temp_c = c(10, 12, 20, 22)
  )

  result <- temperature_function(test_data)

  expect_equal(result$mean_temp_c[result$month == "October"], 11)
  expect_equal(result$mean_temp_c[result$month == "November"], 21)
})

test_that("temperature_function classifies temperatures correctly", {

  test_data <- data.frame(
    date = c("2025-10-01", "2025-11-01", "2025-12-01", "2026-01-01"),
    temp_c = c(10, 18, 25, 32)
  )

  result <- temperature_function(test_data)

  expect_equal(result$classification[result$month == "October"], "Cool - Below Average")
  expect_equal(result$classification[result$month == "November"], "Mild - Average")
  expect_equal(result$classification[result$month == "December"], "Warm - Above Average")
  expect_equal(result$classification[result$month == "January"], "Hot - Boiling")
})

test_that("temperature_function keeps water year month order", {

  test_data <- data.frame(
    date = c("2026-01-01", "2025-10-01", "2026-09-01"),
    temp_c = c(15, 10, 28)
  )

  result <- temperature_function(test_data)

  expect_equal(as.character(result$month), c("October", "January", "September"))
})
