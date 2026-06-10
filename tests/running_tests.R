library(testthat)
library(here)

test_dir(here("tests"))

test_file(here("tests/test_temp_function.R"))

test_file(here("tests/test_oxygen_function.R"))

test_file(here("tests/test_nutrient_function.R"))

test_dir(here("tests"))

