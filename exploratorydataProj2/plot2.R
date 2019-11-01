# load source codes
prefix <- paste0(getwd(), "/exploratorydataProj2/")
source(paste0(prefix, "loadAndCleanData.R"))

# Question 2
# Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland fips == "24510" 
# from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.

subset <- allData[allData$fips == "24510",]

aggData <- subset %>%
  select(year, Emissions) %>%
  group_by(year) %>%
  summarise_all("sum")

png(paste0(prefix, "plot2.png"))
with(aggData, plot(year, Emissions, 
                   type = "l",
                   ylab = "Emissions (total tons)",
                   main = "Baltimore City"))
dev.off()
