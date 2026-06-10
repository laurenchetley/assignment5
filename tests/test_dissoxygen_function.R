library(testthat)
library(dplyr)

source(here::here("R/dissoxygen_function.R"))

test_that("dissoxygen_function calculates monthly means correctly", {

  test_data <- data.frame(
    date = c("2025-10-01", "2025-10-02",
             "2025-11-01", "2025-11-02"),
    do_mg_l = c(1, 3, 7, 9)
  )

  result <- dissoxygen_function(test_data)

  expect_equal(result$mean_dissoxygen[result$month == "October"], 2)
  expect_equal(result$mean_dissoxygen[result$month == "November"], 8)
})

test_that("dissoxygen_function classifies dissolved oxygen correctly", {

  test_data <- data.frame(
    date = c("2025-10-01",
             "2025-11-01",
             "2025-12-01",
             "2026-01-01"),
    do_mg_l = c(1, 4, 7, 10)
  )

  result <- dissoxygen_function(test_data)

  expect_equal(result$classification[result$month == "October"], "Hypoxic")
  expect_equal(result$classification[result$month == "November"], "Stressful")
  expect_equal(result$classification[result$month == "December"], "Moderate")
  expect_equal(result$classification[result$month == "January"], "Excellent")
})

test_that("dissoxygen_function keeps water year month order", {

  test_data <- data.frame(
    date = c("2026-01-01",
             "2025-10-01",
             "2026-09-01"),
    do_mg_l = c(6, 2, 9)
  )

  result <- dissoxygen_function(test_data)

  expect_equal(
    as.character(result$month),
    c("October", "January", "September")
  )
})
