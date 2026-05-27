#Data Script for Nutrient Module 
# Create fake daily nutrient data

set.seed(123)

# Create 365 dates
dates <- seq.Date(
  from = as.Date("2025-10-01"),
  by = "day",
  length.out = 365
)

# Create nutrient data based on seasonal patterns
nutrient_data <- data.frame(
  date = dates,
  
  phosphorus_added = c(
    runif(92, 0.03, 0.10),  # Oct-Dec rainy season
    runif(90, 0.06, 0.14),  # Jan-Mar heavy runoff
    runif(91, 0.04, 0.12),  # Apr-Jun agriculture season
    runif(92, 0.005, 0.03)  # Jul-Sep dry season
  ),
  
  nitrogen_added = c(
    runif(92, 0.65, 1.20),
    runif(90, 0.90, 1.50),
    runif(91, 0.70, 1.40),
    runif(92, 0.20, 0.65)
  )
)

# View first rows
head(nutrient_data)

# Check rows
nrow(nutrient_data)

# Save CSV
write.csv(
  nutrient_data,
  here::here("data", "nutrient_data.csv"),
  row.names = FALSE
)
