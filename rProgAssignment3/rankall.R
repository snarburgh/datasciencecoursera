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

rankall <- function(outcome, num) {

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
  
  # remove where not available
  results[,outcomeCol] <- suppressWarnings(as.numeric(results[,outcomeCol]))
  
  # reset num if given best or worst
  # return NA if num is greater than the options

  
  # set up return data frame
  states <- unique(results$State)
  ranked <- data.frame(hospital = NA,
                       state = states)
  
  # order by state then outcome
  for(s in states) {
    stateResults <- results[results$State == s,]
    stateResults <- stateResults[order(stateResults[,outcomeCol],stateResults[,"Hospital.Name"]),]
    
    maxNum <- nrow(stateResults)
    
    if(num == "best") {
      rank <- 1
    } else if(num == "worst") {
      # remove NAs
      stateResults <- stateResults[which(!is.na(stateResults[,outcomeCol])),]
      maxNum <- nrow(stateResults)
      rank <- maxNum
    } else {
      rank <- num
    }
    
    # find that particularly ranked hospital
    # already sorted by the outcome column
    if(rank > maxNum) {
      value <- NA
    } else {
      value <- stateResults[rank,"Hospital.Name"]
    }
  
    # add to ranked
    ranked[ranked$state == s,"hospital"] <- value
  }
  
  return(ranked)
}
