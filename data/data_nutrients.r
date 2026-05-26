#Data Script for Nutrient Module 
library(tidyverse)
set.seed(123)

# Make 365 dates
dates <- seq.Date(
  from = as.Date("2025-10-01"),
  by = "day",
  length.out = 365
)

# Create nutrient data based on seasonal patterns
nutrient_data <- data.frame(
  date = dates,
  
  phosphorus_added = c(
    runif(92, 0.03, 0.10),  # Oct-Dec: rainy season runoff, eutrophic
    runif(90, 0.06, 0.14),  # Jan-Mar: high winter runoff, eutrophic to hypereutrophic
    runif(91, 0.04, 0.12),  # Apr-Jun: agriculture season, eutrophic to high
    runif(92, 0.005, 0.03)  # Jul-Sep: dry season, lower nutrients
  ),
  
  nitrogen_added = c(
    runif(92, 0.65, 1.20),  # Oct-Dec: rainy season runoff, eutrophic
    runif(90, 0.90, 1.50),  # Jan-Mar: high winter runoff, eutrophic to hypereutrophic
    runif(91, 0.70, 1.40),  # Apr-Jun: agriculture season, eutrophic to high
    runif(92, 0.20, 0.65)   # Jul-Sep: dry season, lower nutrients
  )
)

# View first few rows
head(nutrient_data)

# Check that there are 365 rows
nrow(nutrient_data)

# Add month column so you can group by month later
nutrient_data$month <- format(nutrient_data$date, "%B")

# Calculate monthly means
monthly_nutrient_means <- aggregate(
  cbind(phosphorus_added, nitrogen_added) ~ month,
  data = nutrient_data,
  FUN = mean
)

# View monthly means
monthly_nutrient_means

write.csv(
  nutrient_data,
  here::here("data", "nutrient_data.csv"),
  row.names = FALSE
)
