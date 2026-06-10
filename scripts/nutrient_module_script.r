# Script for Nutrient Module

# This function classifies lake productivity conditions in a given water year.
# Nutrient conditions are classified into four categories:
# Oligotrophic, Mesotrophic, Eutrophic, and Hypereutrophic.
# Mean calculations are based on daily phosphorus and nitrogen
# measurements for each month of the water year.
#
# ---- Input:----
#    A dataframe containing:
#   - date
#   - phosphorus_added (mg/L)
#   - nitrogen_added (mg/L)
#
# ---- Outputs: ----
#   A dataframe containing:
#   - monthly mean phosphorus concentrations
#   - monthly mean nitrogen concentrations
#   - nutrient productivity classification
#
# Possible Classifications:
#   "Oligotrophic"     = Low Productivity
#   "Mesotrophic"      = Medium Productivity
#   "Eutrophic"        = High Productivity
#   "Hypereutrophic"   = Very High Productivity


#' Classify Monthly Nutrient Conditions
#'
#' This function classifies lake productivity conditions in a given
#' water year. Nutrient conditions are classified into four categories:
#' Oligotrophic, Mesotrophic, Eutrophic, and Hypereutrophic. Mean
#' calculations are based on daily phosphorus and nitrogen measurements
#' for each month of the water year.
#'
#' @param nutrientdata A dataframe containing daily phosphorus and
#' nitrogen measurements with date, phosphorus_added, and
#' nitrogen_added columns.
#'
#' @returns A dataframe containing monthly mean phosphorus
#' concentrations, monthly mean nitrogen concentrations, and
#' nutrient productivity classifications.
#'
#' @export


nutrient_function <- function(nutrientdata) {

  # put months in water year order
  water_year_order <- c("October", "November", "December",
                        "January", "February", "March",
                        "April", "May", "June",
                        "July", "August", "September")

  # calculate monthly means
  monthly_means <- nutrientdata |>
    mutate(month = format(as.Date(date), "%B")) |>
    mutate(month = factor(month, levels = water_year_order)) |>
    group_by(month) |>
    summarise(
      mean_phosphorus = round(mean(phosphorus_added, na.rm = TRUE), 2),
      mean_nitrogen = round(mean(nitrogen_added, na.rm = TRUE), 2),
      .groups = "drop"
    )

  # classify nutrient conditions
  monthly_means <- monthly_means |>
    mutate(
      classification = case_when(

        mean_phosphorus < 0.01 &
          mean_nitrogen < 0.35 ~ "Oligotrophic",

        mean_phosphorus >= 0.01 &
          mean_phosphorus <= 0.03 &
          mean_nitrogen >= 0.36 &
          mean_nitrogen <= 0.65 ~ "Mesotrophic",

        mean_phosphorus > 0.03 &
          mean_phosphorus <= 0.10 &
          mean_nitrogen > 0.65 &
          mean_nitrogen <= 1.20 ~ "Eutrophic",

        mean_phosphorus > 0.10 |
          mean_nitrogen > 1.20 ~ "Hypereutrophic",

        TRUE ~ "Mixed Condition"
      )
    )

  return(monthly_means)
}

