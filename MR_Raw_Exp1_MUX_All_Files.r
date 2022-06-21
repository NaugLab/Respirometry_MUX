#Load in Packages
library(dplyr)
library(stringr)
library(foreach)
library(segmented)
library(grDevices)
library(tidyr)
library(zoo)
library(tidyverse)
library(plotly)
library(hrbrthemes)
library(gridExtra)
library(ggpubr)
library(tidyverse)
library(readxl)
library(fs)

#Read in single bee Data files
list.files() #Gives a list of all the files in the directory

# Declare function
load.MR.file <- function(name){
  file <- name
  filename <<- basename(file)
  print(filename)
  Date <<- unlist(strsplit(filename, "[_]"))[1]
  Cohort <<-unlist(strsplit(filename, "[_]"))[2]
  Party <<- unlist(strsplit(filename, "[_]"))[3]
  Week <<- unlist(strsplit(filename, "[_]"))[4]
  Treatment <<- unlist(strsplit(filename, "[_]"))[5]
  Bee <<- unlist(strsplit(filename, "[_]"))[6]
  Bee <<- gsub(".csv", "", Bee)
  In.Data   <- read_csv(file)
  return(In.Data)
}

# Start the actual script
files <- list.files(pattern="*.csv", full.names=TRUE, recursive=FALSE)
lapply(files, function(x) {
  
  In.Data <- load.MR.file(x)
  #Wrangle the data
  In.Data <-  In.Data%>%
    dplyr::rename("Carbon_Dioxide" = "CO2",
                  "Oxygen" = "O2")%>%
    dplyr::select(-c("Temp__Aux2_", "FoxBoxTemp", "FlowSet"))%>% #select variables of interest
    mutate(markers = ifelse(Mux__Aux1_ == "8", "baseline", "MR"),
           Total_Seconds = seq.int(nrow(In.Data))) #Add an indexing column that numbers each row 1: number of rows
  
  
  #Saving baseline and MR measurements to vector objects
  bsln <- which(In.Data$markers == "baseline") #Baseline at beginning
  chbr <- which(In.Data$markers == "MR") #Indicates the switch between baseline and
  
  #Determining the start of each vector
  bsln1 <- bsln[10]
  chbr1 <- chbr[1]
  
  
  #Subset dataframe with just baseline values
  Baseline.df <- dplyr::filter(In.Data, Total_Seconds < chbr1, Total_Seconds > bsln1 )
  #Calculate the average baseline value
  mean_base_CO2 <- mean(Baseline.df$Carbon_Dioxide)
  mean_base_O2 <- mean(Baseline.df$Oxygen)
  
  #Correct Carbon_Dioxide values for mean baseline
  In.Data<- In.Data%>%
    mutate(Carbon_Dioxide_pct = Carbon_Dioxide + abs(mean_base_CO2), #subtract the mean CO2 baseline from the CO2 readings from the foxbox
           Oxygen_pct = mean_base_O2 - Oxygen) #gives the oxygen CONSUMED
  # units still %CO2
  # units still %O2
  
  
  #Add VCO2 to data frame and calculate output values
  ##Get VCO2 by multiplying by the flow rate (in ml/min)
  In.Data<-In.Data%>%
    dplyr::mutate(VCO2 = In.Data$Carbon_Dioxide_pct / 100 * In.Data$Flow_Rate * 60)# mLCO2/hr **on 10/25/18 SM discovered the mistake that multiplying by a percent is stupid, and you need to divide out 100 ... Now (7/8/19) fixed here** Then multiply by flow rate and then by 60
  # units are NOW :: ml CO2 / hr and are fully corrected 
  # essentially equation 10.3 from Lighton 2008 book
  In.Data<-In.Data%>%
    dplyr::mutate(VO2 = In.Data$Oxygen_pct / 100 * In.Data$Flow_Rate * 60) # mL O2 / hr ### may be wrong w/o H2O correction ?? (10/30/19 SM)
  
  In.Data.MR<-In.Data%>%
    filter(Total_Seconds > chbr1 & Total_Seconds < chbr1+(60*25)) # make "usetime" only MR measurements
  
  
  
  
  
  #Summary Statistics
  ##This creates what is essentially a row in the final data set
  sum.stats<-In.Data.MR %>%
    dplyr::summarise(
      Filename = filename,
      Date = Date,
      Cohort = Cohort,
      Party = Party,
      Week = Week,
      Treatment = Treatment,
      Bee = Bee,
      count = n(),
      meanVCO2 = mean(VCO2, na.rm = TRUE),
      sdVCO2 = sd(VCO2, na.rm = TRUE),
      seVCO2 = sd(VCO2) / sqrt((length(VCO2))))
  
  
  #Write a master csv file with each row containing values from a single data file
  ##Create a CSV to populate with rows created for each file above. This originates by making the csv in excel
  MR_master <- read.csv("./Output/MR_Exp1_Master.csv", header = T, sep=",") # Change this to the desired file name for your application
  MR_master$Filename <- as.character(MR_master$Filename)
  str(MR_master)
  
  #Add newest processed row to previous data, overwrite the csv (then move on to the next one)
  MR_master <- rbind(MR_master, sum.stats)
  write.csv(MR_master, "./Output/MR_Exp1_Master.csv", row.names=F)
  
})




