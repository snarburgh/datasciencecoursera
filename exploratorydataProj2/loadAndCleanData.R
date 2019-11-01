# load any source code

# load packages
library(dplyr)
library(ggplot2)
library(lattice)

# Step 1: Load and Clean Data

# load data
prefix <- paste0(getwd(), "/exploratorydataProj2/")
data <- readRDS(paste0(prefix, "summarySCC_PM25.rds"))
sourceCodes <- readRDS(paste0(prefix, "Source_Classification_Code.rds"))

# make dfs
data <- as.data.frame(data)
sourceCodes <- as.data.frame(sourceCodes)

# only want SCC and Short.Name
keep <- c("SCC", "Short.Name", "SCC.Level.One")
sourceCodes <- sourceCodes[,keep]

# merge to get human friendly source code
allData <- merge(data, sourceCodes, by = "SCC")

# outputs allData

