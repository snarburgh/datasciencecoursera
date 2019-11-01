# load source codes
prefix <- paste0(getwd(), "/exploratorydataProj2/")
source(paste0(prefix, "loadAndCleanData.R"))

#Question 6
# Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California 
# fips == "06037". 
# Which city has seen greater changes over time in 
# motor vehicle emissions?

subset <- allData[(allData$fips %in% c("24510", "06037") & allData$type == "ON-ROAD"),]

aggData <- subset %>%
  select(year, Emissions,fips) %>%
  group_by(year, fips) %>%
  summarise_all("sum")

p <- ggplot(aggData) +
  geom_line(aes(x=year, y = Emissions, col = fips)) +
  ggtitle("LA vs Baltimore On-Road Emissions")
ggsave(filename = paste0(prefix, "plot6.png"),
       plot = p,
       device = "png")


