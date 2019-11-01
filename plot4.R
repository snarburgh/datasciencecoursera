# script for producing plot 4
# required packages

# required files
source("getdata_course4.R")
# stores data subset in "testData" variable

png("plot4.png",
    height = 480,
    width =480)
# set how many plots to make
par(mfrow = c(2,2))
par(mar=c(2,4,2,2))

# top left corner plot
plot(testData$DateTime, testData$Global_active_power,
     type = "l",
     ylab = "Global Active Power",
     xlab = "")

#top right corner
plot(testData$DateTime, testData$Voltage,
     type = "l",
     ylab = "Voltage",
     xlab = "DateTime")

# bottom left corner
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
       col=c("black", "red", "blue"))

# bottom right corner
plot(testData$DateTime, testData$Global_reactive_power,
     type = "l",
     ylab = "Global Rective Power",
     xlab = "DateTime")
#dev.off()
