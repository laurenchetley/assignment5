# Script for Dissolved Oxygen Module

# This script classifies lake dissolved oxygen conditions based on
# dissolved oxygen concentrations in mg/L. The function organizes daily
# dissolved oxygen data by water year month, calculates monthly mean
# dissolved oxygen, and assigns a dissolved oxygen classification for
# each month.
#
# ---- Classifications ----
# Hypoxic   = Very low oxygen conditions, DO < 2 mg/L
# Stressful = Low oxygen conditions, DO 2-5 mg/L
# Moderate  = Moderate oxygen conditions, DO 5-8 mg/L
# Excellent = High oxygen conditions, DO > 8 mg/L

# dissolved oxygen model function
#' Classify Monthly Dissolved Oxygen Conditions
#'
#' @description
#' Processes daily dissolved oxygen (DO) measurements from a lake or water body
#' Organizes the data by water year month order (October through September)
#' Calculates monthly mean DO concentrations, and assigns a classififcation to each month based on established oxygen thresholds
#'
#' Hypoxic   = Very low oxygen conditions, DO < 2 mg/L
#' Stressful = Low oxygen conditions, DO 2-5 mg/L
#' Moderate  = Moderate oxygen conditions, DO 5-8 mg/L
#' Excellent = High oxygen conditions, DO > 8 mg/L
#'
#' @param dissoxygendata A data frame containing daily dissolved oxygen observations.
#' The data frame must include: date of observation and daily dissolved oxygen concentration in milligrams per liter (mg/L)
#'
#' @returns A data frame summarizing monthly dissolved oxygen conditions, including the month, mean dissolved oxygen concentration (mg/L), and dissolved oxygen classification
dissoxygen_function <- function(dissoxygendata) {

  # put them in order
  water_year_order <- c("October", "November", "December",
                        "January", "February", "March",
                        "April", "May", "June",
                        "July", "August", "September")

  # calculate the monthly means
  monthly_means <- dissoxygendata |>
    mutate(month = format(as.Date(date), "%B")) |>
    mutate(month = factor(month, levels = water_year_order)) |>
    group_by(month) |>
    summarise(
      mean_dissoxygen = round(mean(do_mg_l, na.rm = TRUE), 2),
      .groups = "drop"
    )

  # classify dissolved oxygen
  monthly_means <- monthly_means |>
    mutate(classification = case_when(
      mean_dissoxygen < 2 ~ "Hypoxic",
      mean_dissoxygen >= 2 & mean_dissoxygen <= 5 ~ "Stressful",
      mean_dissoxygen > 5 & mean_dissoxygen <= 8 ~ "Moderate",
      mean_dissoxygen > 8 ~ "Excellent"
    ))

  return(monthly_means)
}
