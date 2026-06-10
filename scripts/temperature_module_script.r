# Script for Temperature Module

# This function classifies lake mean surface water temperature in a given water year.
# The water temperatures will be classified into four categories: Cool, Mild, Warm, and Hot.
# Mean calculations were based on daily surface water temperatures for 365 days.
#
# ---- Input:----
#    A dataframe containing:
#   - date
#   - temp_c
#
#----- Outputs: ----
#   A dataframe containing:
#   - monthly mean surface water temperatures
#   - temperature classification

# Possible Classifications:
#   "Cool"         = Below Average
#   "Mild"         = Average
#   "Warm"         = Above Average
#   "Hot"          = Boiling

#' Classify Monthly Dissolved Oxygen Conditions
#'
#' This function classifies lake dissolved oxygen conditions in a given
#' water year. Dissolved oxygen concentrations are classified into four
#' categories: Hypoxic, Stressful, Moderate, and Excellent. Mean
#' calculations are based on daily dissolved oxygen measurements for
#' each month of the water year.
#'
#' @param dissoxygendata A dataframe containing daily dissolved oxygen
#' measurements with date and dissolved oxygen concentration columns.
#'
#' @returns A dataframe containing monthly mean dissolved oxygen
#' concentrations and dissolved oxygen classifications.
#'
#' @export


# classification water temperature
temperature_function <- function(data) {

  water_year_order <- c("October", "November", "December",
                        "January", "February", "March",
                        "April", "May", "June",
                        "July", "August", "September")

  monthly_means <- data |>
    mutate(month = format(as.Date(date), "%B")) |>
    mutate(month = factor(month, levels = water_year_order)) |>
    group_by(month) |>
    summarise(mean_temp_c = round(mean(temp_c, na.rm = TRUE), 2)) |>
    arrange(month)

  monthly_means <- monthly_means |>
    mutate(
      classification = sapply(mean_temp_c, function(mean_temp_c) {
        if (mean_temp_c < 13)                          { "Cool - Below Average"  }
        else if (mean_temp_c >= 13 & mean_temp_c <= 22) { "Mild - Average"        }
        else if (mean_temp_c > 22 & mean_temp_c <= 30)  { "Warm - Above Average"  }
        else if (mean_temp_c > 30)                      { "Hot - Boiling"         }
      })
    )

  return(monthly_means)
}
