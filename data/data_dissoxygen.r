# Create fake daily dissolved oxygen data

set.seed(123)

# Create 365 dates
dates <- seq.Date(
  from = as.Date("2025-10-01"),
  by = "day",
  length.out = 365
)

# Create dissolved oxygen data based on seasonal patterns
dissoxygen_data <- data.frame(
  date = dates,
  
  do_mg_l = c(
    
    # Fall
    runif(31, 7, 9),     # October: moderate to excellent
    runif(30, 6, 8),     # November: moderate
    runif(31, 8, 10),    # December: excellent
    
    # Winter
    runif(31, 9, 11),    # January: excellent
    runif(28, 8, 10),    # February: excellent
    runif(31, 6, 8),     # March: moderate
    
    # Spring
    runif(30, 5, 7),     # April: moderate
    runif(31, 3, 5),     # May: stressful
    runif(30, 2, 4),     # June: stressful
    
    # Summer
    runif(31, 1, 2),     # July: hypoxic
    runif(31, 1, 2),     # August: hypoxic
    runif(30, 3, 5)      # September: stressful
  )
)

# View first rows
head(dissoxygen_data)

# Check rows
nrow(dissoxygen_data)

# Save CSV
write.csv(
  dissoxygen_data,
  here::here("data", "dissoxygen_data.csv"),
  row.names = FALSE
)
