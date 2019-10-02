# script for producing plot 1
# required packages

# required files
source("getdata_course4.R")
# stores data subset in "testData" variable

# convert to numeric
testData$Global_active_power <- as.numeric(testData$Global_active_power) 

png("plot1.png",
    width = 480,
    height = 480)
hist(x = testData$Global_active_power,
     breaks = 15,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.off()
