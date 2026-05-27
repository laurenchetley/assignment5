# Script for Dissolved Oxygen Module

#loading in the libraries 
library(tidyverse)
library(dplyr)
library(here)
library(ggplot2)
library(janitor)

#classification water temperature 
dissoxygen_classification<- function(mean_dissoxygen){
  if(mean_dissoxygen<2){dissoxygen_class<-"Hypoxic"}
  else if(mean_dissoxygen>=2&&mean_dissoxygen<=5){dissoxygen_class<-"Stressful"}
  else if (mean_dissoxygen>5&&mean_dissoxygen<=8){dissoxygen_class<-"Moderate"}
  else if (mean_dissoxygen>8){dissoxygen_class<-"Excellent"}
  return(dissoxygen_class)
}

#test with fake data
dissoxygen_classification(1)
dissoxygen_classification(3)
dissoxygen_classification(6)
dissoxygen_classification(10)
#it works 

#load in the data 
dissoxygendata<-read.csv(here("data","dissoxygen_data.csv"))
#put them in order 
water_year_order <- c("October", "November", "December",
                      "January", "February", "March",
                      "April", "May", "June",
                      "July", "August", "September")
#calculate the monthly means 
monthly_means <- dissoxygendata |>
  mutate(month = factor(month, levels = water_year_order)) |>
  group_by(month) |>
  summarise(mean_dissoxygen = round(mean(do_mg_l, na.rm = TRUE), 2))

print(monthly_means)

#testing the function
monthly_means <- monthly_means |>
  mutate(classification = sapply(mean_dissoxygen, dissoxygen_classification))

#show results 
print(monthly_means)




