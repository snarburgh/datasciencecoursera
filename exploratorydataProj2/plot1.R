# load source codes
prefix <- paste0(getwd(), "/exploratorydataProj2/")
source(paste0(prefix, "loadAndCleanData.R"))

# Question 1:
# Have total emissions from PM2.5 decreased in the US 
# from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all
# sources for each of the years 1999, 2002, 2005, and 2008

# group by year and source then aggregate by sum
aggData <- allData %>%
  select(year, Emissions) %>%
  group_by(year) %>%
  summarise_all("sum")

png(paste0(prefix, "plot1.png"),
    width = 1080,
    height = 700)
with(aggData,
     plot(year, Emissions,
          type ="l",
          ylab = "Emissions (total tons)",
          main = "PM2.5"))
dev.off()

