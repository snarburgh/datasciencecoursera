# Write a function that reads a directory full of files and reports the number of completely observed cases 
# in each data file. The function should return a data frame where the first column is the name of the file 
# and the second column is the number of complete cases. A prototype of this function follows

# directory is a character vector of length 1 indicating the location of the CSV files
# id is an integrer vector including which files to use

# packages
library(data.table)
library(dplyr)

complete <- function(directory, id=1:332) {
  
  if(length(directory) > 1) {
    return("Invalid directory")
  } else {
    
    # check for final slash
    if(str_sub(directory, nchar(directory), nchar(directory)) != "/") {
      directory <- paste(directory, "/", sep="")
    }
    
    # create empty df
    ids <- sprintf("%03d", id)
    completeDf <- data.frame(id = ids, nobs = NA)
    
    # loop through ids and count n observations in each file
    for(f in 1:length(ids)) {
      fileName <- paste(directory,ids[f],'.csv', sep="")
      tempDf <- fread(fileName)
      
      # find complete cases
      cc <- length(which(complete.cases(tempDf)))
      
      # update nobs in df
      completeDf[completeDf$id == ids[f], "nobs"] <- cc
    }
    return(completeDf)
  }
}

