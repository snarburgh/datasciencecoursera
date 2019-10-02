# script for producing plot 3
# required packages

# required files
source("getdata_course4.R")
# stores data subset in "testData" variable

png("plot3.png",
    height = 480,
    width = 480)
# metering 1
plot(testData$DateTime, 
     testData$Sub_metering_1,
     type = "l",
     col = "black",
     ylab = "Energy sub metering",
     xlab = "")
# meeting 2
lines(testData$DateTime, 
      testData$Sub_metering_2, 
      col = "red", 
      type = "l")
# meeting 3
lines(testData$DateTime, 
      testData$Sub_metering_3, 
      col = "blue", 
      type = "l")
# Add a legend to the plot
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), 
       lty = 1:2, 
       cex=0.8)
dev.off()
