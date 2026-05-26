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
  
  if (total_p < 0.01 && total_n < 0.35) {
    nutrient_class <- "Oligotrophic"
    
  } else if (total_p >= 0.01 && total_p <= 0.03 &&
             total_n >= 0.36 && total_n <= 0.65) {
    nutrient_class <- "Mesotrophic"
    
  } else if (total_p > 0.03 && total_p <= 0.10 &&
             total_n > 0.65 && total_n <= 1.20) {
    nutrient_class <- "Eutrophic"
    
  } else if (total_p > 0.10 || total_n > 1.20) {
    nutrient_class <- "Hypereutrophic"
    
  } else {
    nutrient_class <- "Mixed or unclear nutrient condition"
  }
  
  return(nutrient_class)
}






