# Script for Nutrient Module

# Classifies lake nutrient status based on total phosphorus and total nitrogen
#
# ---- Inputs:---- 
#   total_p: total phosphorus in mg/L
#   total_n: total nitrogen in mg/L
#
#----- Output: ----
#   A nutrient classification:
#   "Oligotrophic", "Mesotrophic", "Eutrophic", or "Hypereutrophic"


nutrient_model <- function(total_p, total_n) {
  
  # Calculate means
  mean_p <- mean(total_p)
  mean_n <- mean(total_n)
  
  # Classification
  if (mean_p < 0.01 && mean_n < 0.35) {
    
    nutrient_class <- "Oligotrophic"
    
  } else if (mean_p >= 0.01 && mean_p <= 0.03 &&
             mean_n >= 0.36 && mean_n <= 0.65) {
    
    nutrient_class <- "Mesotrophic"
    
  } else if (mean_p > 0.03 && mean_p <= 0.10 &&
             mean_n > 0.65 && mean_n <= 1.20) {
    
    nutrient_class <- "Eutrophic"
    
  } else if (mean_p > 0.10 || mean_n > 1.20) {
    
    nutrient_class <- "Hypereutrophic"
    
  } else {
    
    nutrient_class <- "Mixed Condition"
  }
  
  # Return results
  return(list(
    Mean_Phosphorus = mean_p,
    Mean_Nitrogen = mean_n,
    Nutrient_Class = nutrient_class
  ))
}





