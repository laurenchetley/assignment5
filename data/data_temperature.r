# Create fake daily water temperature data

set.seed(123)

# Create 365 dates
dates <- seq.Date(
  from = as.Date("2025-10-01"),
  by = "day",
  length.out = 365
)

# Create temperature data based on seasonal patterns
temperature_data <- data.frame(
  date = dates,
  
  temp_c = c(
    runif(31, 8, 12),   # October: cool
    runif(30, 12, 14),  # November: cool
    runif(31, 9, 12),   # December: cool
    
    runif(31, 8, 12),   # January: cool
    runif(28, 10, 13),  # February: cool
    runif(31, 13, 16),  # March: mild
    
    runif(30, 16, 21),  # April: mild
    runif(31, 20, 24),  # May: warm
    runif(30, 22, 27),  # June: warm
    
    runif(31, 26, 31),  # July: warm to hot
    runif(31, 30, 34),  # August: hot
    runif(30, 24, 29)   # September: warm
  )
)

# View first rows
head(temperature_data)

# Check rows
nrow(temperature_data)

# Save CSV
write.csv(
  temperature_data,
  here::here("data", "temperature_data.csv"),
  row.names = FALSE
)