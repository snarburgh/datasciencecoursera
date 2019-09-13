# programming assignment 3

# plot 30 day mortality rates for heart attacks
outcome <- read.csv("rProgAssignment3/outcome-of-care-measures.csv", 
                    colClasses = "character")
head(outcome)


# col 11 is of interest
# outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])


# find the best hospital in the state
# give it a state abbreviattion and a specific outcome
# return the Hospital.Name with the lowest (best)
# rate for the specific state

# possible outcomes: heart attack, heart failure, pneumonia

# required libraries and data
library(dplyr)
# read in results
results <<- read.csv("rProgAssignment3/outcome-of-care-measures.csv", 
                     colClasses = "character")

rankhospital <- function(state, outcome, num) {
  # check if state abbreviation is ok
  states <- unique(results$State)
  try(if(nchar(state) != 2) stop("Invalid state"))
  try(if(!any(state %in% states)) stop("Invalid state"))
  
  # check outcome
  options <- c("heart attack", "heart failure", "pneumonia")
  try(if(!any(outcome %in% options)) stop("Invalid outcome"))
  
  # need to check if num is best, worst, or an integer?
  
  # find correct column
  # heart attack = col 11
  # heart failure = col 17
  # pneumonia = col 23
  outcomeCol <- switch(outcome,
                       "heart attack" = 11,
                       "heart failure" = 17,
                       "pneumonia" = 23)
  
  stateResults <- results[results$State == state,]
  
  # remove where not available
  stateResults[,outcomeCol] <- suppressWarnings(as.numeric(stateResults[,outcomeCol]))
  stateResults <- stateResults[which(!is.na(stateResults[,outcomeCol])),]
  
  # check num variable
  maxNum <- length(unique(stateResults$Hospital.Name))
  
  # reset num if given best or worst
  # return NA if num is greater than the options
  if(num == "best") {
    rank <- 1
  } else if(num == "worst") {
    rank <- maxNum
  } else if(num > maxNum) {
    return(NA)
  } else {
    rank <- num
  }
  
  # sort the state results by the variable chosen
  stateResults <- stateResults[order(stateResults[,outcomeCol],stateResults[,"Hospital.Name"]),]
  
  return(stateResults[rank,"Hospital.Name"])
  
}
