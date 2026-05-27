# Script for Nutrient Module

# This function organizes daily phosphorus and nitrogen data
# by water year month, calculates monthly mean nutrient levels,
# and classifies lake productivity conditions based on nutrient
# concentration thresholds.
#
# ---- Inputs: ----
# nutrientdata:
#   A dataframe containing:
#   - month
#   - phosphorus_added (mg/L)
#   - nitrogen_added (mg/L)
#
# ---- Output: ----
# A dataframe containing:
#   - monthly mean phosphorus concentrations
#   - monthly mean nitrogen concentrations
#   - nutrient productivity classification
#
# Possible classifications:
#   "Oligotrophic"      = Low productivity
#   "Mesotrophic"       = Medium productivity
#   "Eutrophic"         = High productivity
#   "Hypereutrophic"    = Very high productivity


# nutrient classification function
nutrient_model <- function(nutrientdata) {
  
  # put months in water year order
  water_year_order <- c("October", "November", "December",
                        "January", "February", "March",
                        "April", "May", "June",
                        "July", "August", "September")
  
  # calculate monthly means
  monthly_means <- nutrientdata |>
    mutate(month = factor(month, levels = water_year_order)) |>
    group_by(month) |>
    summarise(
      mean_phosphorus = round(mean(phosphorus_added, na.rm = TRUE), 2),
      mean_nitrogen = round(mean(nitrogen_added, na.rm = TRUE), 2)
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

