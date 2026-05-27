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




