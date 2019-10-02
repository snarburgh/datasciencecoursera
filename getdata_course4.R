# file for reading in data
# outputs dataframe called "testData" with the window for the hw
# required packages
library(readxl)
library(dplyr)

# source data
# make sure it is in your working directory
testData <- as.data.frame(read.csv("household_power_consumption.txt",
                                     sep=";",
                                     header = TRUE))

# convert dates and times
testData$DateTime <- paste(testData$Date, testData$Time)
testData$DateTime <- as.POSIXct(testData$DateTime,
                               "%d/%m/%Y %H:%M:%S",
                               tz="UTC")

# wanted date range
# 2007-02-01 and 2007-02-02
testData <- testData %>% 
  filter(DateTime >= as.POSIXct("2007-02-01 00:00:00")) %>%
  filter(DateTime < as.POSIXct("2007-02-03 00:00:00"))

