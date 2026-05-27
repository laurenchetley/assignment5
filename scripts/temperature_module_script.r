# Script for Temperature Module


#loading in the libraries 
library(tidyverse)
library(dplyr)
library(here)
library(ggplot2)
library(janitor)

#classification water temperature 
temp_classification<- function(mean_temp_c){
  if(mean_temp_c<13){temp_class<-"Cool - Below Average"}
  else if(mean_temp_c>=13&&mean_temp_c<=22){temp_class<-"Mild - Average"}
  else if (mean_temp_c>22&&mean_temp_c<=30){temp_class<-"Warm - Above Average"}
  else if (mean_temp_c>30){temp_class<-"Hot - Boiling"}
  return(temp_class)
}

#test with fake data
temp_classification(10)
temp_classification(18)
temp_classification(25)
temp_classification(35)
#it works 

#load in the data 
watertempdata<-read.csv(here("data","surfacewater_data.csv"))
#put them in order 
water_year_order <- c("October", "November", "December",
                      "January", "February", "March",
                      "April", "May", "June",
                      "July", "August", "September")
#calculate the monthly means 
monthly_means <- watertempdata |>
  mutate(month=factor(month,levels=water_year_order))|>
  group_by(month) |>
  summarise(mean_temp_c=round(mean(surface_temp_c, na.rm=TRUE), 2))

print(monthly_means)
 
#test with you function 
monthly_means <- monthly_means |>
  mutate(classification = sapply(mean_temp_c, temp_classification))

#show results 
print(monthly_means)
