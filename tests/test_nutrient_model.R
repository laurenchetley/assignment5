library(testthat)
library(dplyr)

source(here::here("R/nutrient_function.R"))

test_that("nutrient_function calculates monthly means correctly", {
  
  test_data <- data.frame(
    date = c("2025-10-01", "2025-10-02",
             "2025-11-01", "2025-11-02"),
    phosphorus_added = c(0.01, 0.03, 0.08, 0.10),
    nitrogen_added = c(0.36, 0.64, 1.00, 1.20)
  )
  
  result <- nutrient_function(test_data)
  
  expect_equal(result$mean_phosphorus[result$month == "October"], 0.02)
  expect_equal(result$mean_nitrogen[result$month == "October"], 0.50)
  
  expect_equal(result$mean_phosphorus[result$month == "November"], 0.09)
  expect_equal(result$mean_nitrogen[result$month == "November"], 1.10)
})

test_that("nutrient_function classifies nutrient conditions correctly", {
  
  test_data <- data.frame(
    date = c("2025-10-01",
             "2025-11-01",
             "2025-12-01",
             "2026-01-01",
             "2026-02-01"),
    phosphorus_added = c(0.005, 0.02, 0.05, 0.15, 0.02),
    nitrogen_added = c(0.20, 0.50, 0.90, 1.30, 1.00)
  )
  
  result <- nutrient_function(test_data)
  
  expect_equal(result$classification[result$month == "October"], "Oligotrophic")
  expect_equal(result$classification[result$month == "November"], "Mesotrophic")
  expect_equal(result$classification[result$month == "December"], "Eutrophic")
  expect_equal(result$classification[result$month == "January"], "Hypereutrophic")
  expect_equal(result$classification[result$month == "February"], "Mixed Condition")
})

test_that("nutrient_function keeps water year month order", {
  
  test_data <- data.frame(
    date = c("2026-01-01",
             "2025-10-01",
             "2026-09-01"),
    phosphorus_added = c(0.02, 0.005, 0.15),
    nitrogen_added = c(0.50, 0.20, 1.40)
  )
  
  result <- nutrient_function(test_data)
  
  expect_equal(
    as.character(result$month),
    c("October", "January", "September")
  )
})