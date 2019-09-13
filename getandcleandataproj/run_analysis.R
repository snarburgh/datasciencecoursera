# required packages
library(readxl)
library(dplyr)

# loading data
testData <- read.table("~/Documents/coursera/datasciencecoursera/getandcleandataproj/UCI HAR Dataset/test/X_test.txt", 
                       quote="\"", 
                       comment.char="", 
                       stringsAsFactors=FALSE)

testLabel <- read.table("~/Documents/coursera/datasciencecoursera/getandcleandataproj/UCI HAR Dataset/test/Y_test.txt", 
                        quote="\"", 
                        comment.char="", 
                        stringsAsFactors=FALSE)

testSubject <- read.table("~/Documents/coursera/datasciencecoursera/getandcleandataproj/UCI HAR Dataset/test/subject_test.txt", 
                          quote="\"", 
                          comment.char="", 
                          stringsAsFactors=FALSE)

trainData <- read.table("~/Documents/coursera/datasciencecoursera/getandcleandataproj/UCI HAR Dataset/train/X_train.txt", 
                        quote="\"", 
                        comment.char="", 
                        stringsAsFactors=FALSE)

trainLabel <- read.table("~/Documents/coursera/datasciencecoursera/getandcleandataproj/UCI HAR Dataset/train/Y_train.txt", 
                         quote="\"", 
                         comment.char="", 
                         stringsAsFactors=FALSE)
trainSubject <- read.table("~/Documents/coursera/datasciencecoursera/getandcleandataproj/UCI HAR Dataset/train/subject_train.txt", 
                           quote="\"", 
                           comment.char="", 
                           stringsAsFactors=FALSE)

features<- read.table("~/Documents/coursera/datasciencecoursera/getandcleandataproj/UCI HAR Dataset/features.txt", 
                      quote="\"", 
                      comment.char="", 
                      stringsAsFactors=FALSE)

activityLabels <- read.table("~/Documents/coursera/datasciencecoursera/getandcleandataproj/UCI HAR Dataset/activity_labels.txt", 
                             quote="\"", 
                             comment.char="", 
                             stringsAsFactors=FALSE)
activityLabels <- as.data.frame(activityLabels)

# merge test and train into one dataframe
# add subject IDs
masterData <- as.data.frame(rbind(testData, trainData))

# update column names
colNames <- features$V2
colnames(masterData)<- colNames
colnames(activityLabels) <- c("label", "activity")

# add subject info
masterSubjects <- rbind(testSubject, trainSubject)
masterData$subID <- masterSubjects
masterData <- as.data.frame(masterData)

# update activity
labels <- rbind(testLabel, trainLabel)
labels <- as.data.frame(labels)
labels$activity <- activityLabels$activity[match(labels$V1, activityLabels$label)]
masterData$label<- labels[,1]
masterData$activity <- labels[,2]

# grab only meana nd std dev measures
colNames <- colnames(masterData)
keepCols <- grep("mean|std|label|activity|subID", colNames)
subsetMaster <- as.data.frame(masterData[,keepCols])

# convert to numeric
numCols <- grep("std|mean",colnames(subsetMaster))
subsetMaster[,numCols] <- sapply(subsetMaster[,numCols],
                                 as.numeric)
subsetMaster$subID <- as.numeric(subsetMaster$subID)

# make df that includes mean for each 
# variable for each activity and each subject

aggData <- subsetMaster %>%
  select(-label) %>%
  group_by(activity,subID) %>%
  summarise_all("mean")


