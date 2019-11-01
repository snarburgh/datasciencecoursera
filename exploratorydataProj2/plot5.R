# load source codes
prefix <- paste0(getwd(), "/exploratorydataProj2/")
source(paste0(prefix, "loadAndCleanData.R"))

# question 5
# How have emissions from motor vehicle sources 
# changed from 1999–2008 in Baltimore City?

subset <- allData[(allData$fips == "24510" & allData$type == "ON-ROAD"),]

aggData <- subset %>%
  select(year, Emissions) %>%
  group_by(year) %>%
  summarise_all("sum")

p <- ggplot(aggData) +
  geom_line(aes(x=year, y=Emissions)) +
  ggtitle("Baltimore On-Road Emissions")
ggsave(filename = paste0(prefix, "plot5.png"),
       plot = p,
       device = "png")
