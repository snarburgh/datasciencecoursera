# load source codes
prefix <- paste0(getwd(), "/exploratorydataProj2/")
source(paste0(prefix, "loadAndCleanData.R"))

# Question 3:
# Of the four types of sources indicated by the 
# type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases 
# in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer 
# this question.

subset <- allData[allData$fips == "24510",]

aggData <- subset %>%
  select(year, type, Emissions) %>%
  group_by(year, type) %>%
  summarise_all("sum") %>%
  as.data.frame()

colnames(aggData) <- c("year", "dataType", "Emissions")

# use ggplot
p <- ggplot(aggData,
            aes(x=year, y = Emissions)) +
  geom_line(aes(col = dataType)) +
  ggtitle("Total Baltimore Emissions")
ggsave(filename = paste0(prefix, "plot3.png"),
       plot = p,
       device = "png")
