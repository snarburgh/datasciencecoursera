# Write a function that takes a directory of data files and a threshold for complete cases 
# and calculates the correlation between sulfate and nitrate for monitor locations where the 
# number of completely observed cases (on all variables) is greater than the threshold. 
# The function should return a vector of correlations for the monitors that meet the threshold requirement. 
# If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0. 

# directory is a string fector of length 1 with the path
# threshold is an integer for min complete cases
# return a numeric vector of correlations

# packages
library(dplyr)
library(stringr)
library(data.table)

# source files
source("pollutantmean.R")
source("complete.R")

corr <- function(directory, threshold = 0) {
  
  if(length(directory) > 1) {
    return("Invalid directory")
  } else {
    
    # check for final slash
    if(str_sub(directory, nchar(directory), nchar(directory)) != "/") {
      directory <- paste(directory, "/", sep="")
    }
    
    # find which cases are above threshold
    cc <- complete(directory)
    cc <- cc[which(cc$nobs > threshold),]
    if(nrow(cc) == 0) {
      return(numeric(0))
    }
    
    # find correlations between sulfate and nitrate for those ids
    ids <- cc$id
    corrs <- c()
    for(f in ids) {
      fileName <- paste(directory,f,'.csv', sep="")
      tempDf <- fread(fileName)
      corrTemp <- cor(tempDf$sulfate, tempDf$nitrate, use="complete.obs")
      corrs <- c(corrs, corrTemp)
    }
    return(corrs)
  }
}
