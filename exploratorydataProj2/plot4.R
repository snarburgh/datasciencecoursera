# load source codes
prefix <- paste0(getwd(), "/exploratorydataProj2/")
source(paste0(prefix, "loadAndCleanData.R"))

# Qustion 4
#Across the United States, how have emissions 
# from coal combustion-related sources 
# changed from 1999–2008?

# grab coal comb rows related short names
coalRows <- grep("Coal", 
                 allData$Short.Name,
                 ignore.case = TRUE)
subset <- allData[coalRows,]

aggData <- subset %>%
  select(Emissions, year, type) %>%
  group_by(year, type) %>%
  summarise_all("sum")

p <- ggplot(aggData) +
  geom_line(aes(x=year, y = Emissions, col = type)) +
  ggtitle("Total Coal Emissions")
ggsave(filename = paste0(prefix, "plot4.png"),
       plot = p,
       device = "png")
