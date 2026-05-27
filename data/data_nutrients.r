# Data Script for Nutrient Module 

set.seed(123)

# Create 365 dates
dates <- seq.Date(
  from = as.Date("2025-10-01"),
  by = "day",
  length.out = 365
)

# Create nutrient data based on monthly seasonal patterns
nutrient_data <- data.frame(
  date = dates,
  
  phosphorus_added = c(
    runif(31, 0.001, 0.004), # October: oligotrophic
    runif(30, 0.015, 0.025), # November: mesotrophic
    runif(31, 0.001, 0.004), # December: oligotrophic
    
    runif(31, 0.001, 0.004), # January: oligotrophic
    runif(28, 0.015, 0.025), # February: mesotrophic
    runif(31, 0.015, 0.025), # March: mesotrophic
    
    runif(30, 0.040, 0.080), # April: eutrophic
    runif(31, 0.040, 0.080), # May: eutrophic
    runif(30, 0.040, 0.080), # June: eutrophic
    
    runif(31, 0.001, 0.004), # July: oligotrophic
    runif(31, 0.110, 0.140), # August: hypereutrophic
    runif(30, 0.015, 0.025)  # September: mesotrophic
  ),
  
  nitrogen_added = c(
    runif(31, 0.10, 0.30),   # October: oligotrophic
    runif(30, 0.40, 0.60),   # November: mesotrophic
    runif(31, 0.10, 0.30),   # December: oligotrophic
    
    runif(31, 0.10, 0.30),   # January: oligotrophic
    runif(28, 0.40, 0.60),   # February: mesotrophic
    runif(31, 0.40, 0.60),   # March: mesotrophic
    
    runif(30, 0.80, 1.10),   # April: eutrophic
    runif(31, 0.80, 1.10),   # May: eutrophic
    runif(30, 0.80, 1.10),   # June: eutrophic
    
    runif(31, 0.10, 0.30),   # July: oligotrophic
    runif(31, 1.30, 1.50),   # August: hypereutrophic
    runif(30, 0.40, 0.60)    # September: mesotrophic
  )
)

# Add month column
nutrient_data$month <- format(nutrient_data$date, "%B")

# Check monthly means before saving
nutrient_data |>
  group_by(month) |>
  summarise(
    mean_phosphorus = round(mean(phosphorus_added), 2),
    mean_nitrogen = round(mean(nitrogen_added), 2)
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