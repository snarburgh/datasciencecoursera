# script for producing plot 2
# required packages

# required files
source("getdata_course4.R")
# stores data subset in "testData" variable

png("plot2.png",
    height = 480,
    width = 480)
plot(testData$DateTime, testData$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()
