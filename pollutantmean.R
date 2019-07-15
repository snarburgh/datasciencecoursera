# Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) 
# across a specified list of monitors. The function 'pollutantmean' takes three arguments: 
# 'directory', 'pollutant', and 'id'. 
# Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data 
# from the directory specified in the 'directory' argument and returns the mean of the pollutant 
# across all of the monitors, ignoring any missing values coded as NA. A prototype of the function is as follows

# directory is a character vector of length 1 indicating the location of the CSV files
# pollutant is a character vector of length 1 indicating the name of the pollutant (sukfate or nitrate)
# id is an integrer vector including which files to use
# return the mean of the pollutant across all id files, removing na, and do not round the result

# packages
library(data.table)
library(dplyr)
library(stringr)

d <- paste0(getwd(), "/specdata/")

pollutantmean <- function(directory, pollutant, id = 1:332) {
  options <- c("sulfate", "nitrate")
  if(!(any(pollutant %in% options)) | length(pollutant) > 1 | length(directory) > 1) {
    return("INvalid argument")
  } else {
    
    # check for final slash
    if(str_sub(directory, nchar(directory), nchar(directory)) != "/") {
      directory <- paste(directory, "/", sep="")
    }
    
    # get the files and combine into one master df
    id <- sprintf("%03d", id)
    masterDf <- data.frame()
    for (f in id) {
      fileName <- paste(directory,f,'.csv', sep="")
      tempDf <- fread(fileName)
      masterDf <- rbind(masterDf, tempDf)
    }
    
    masterDf <- as.data.frame(masterDf)
    
    # calculate the mean
    avg <- mean(masterDf[,pollutant], na.rm = TRUE)
    return(avg)
  }
}
