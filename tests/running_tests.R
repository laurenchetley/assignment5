library(testthat)
library(here)

test_dir(here("tests/testthat"))

test_file(here("tests/testthat/test_temperature_function.R"))

test_file(here("tests/testthat/test_dissoxygen_function.R"))

test_file(here("tests/testthat/test_nutrient_function.R"))

test_dir(here("tests/testthat"))