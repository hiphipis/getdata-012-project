#

library(data.table)
library(LaF)
library(dplyr)

load_data_set <- function () {
  
pathToDataSet <- "./UCI HAR Dataset"
folderTrainData <- "train"
folderTestData <- "test"

fnFeatures <- paste(pathToDataSet, "features.txt", sep="/")
fnActivities <- paste(pathToDataSet, "activity_labels.txt", sep="/")

fnTrnData <- paste(pathToDataSet, folderTrainData, "X_train.txt", sep="/")
fnTrnLabels <- paste(pathToDataSet, folderTrainData, "y_train.txt", sep="/")
fnTrnSubj <- paste(pathToDataSet, folderTrainData, "subject_train.txt", sep="/")

fnTstData <- paste(pathToDataSet, folderTestData, "X_test.txt", sep="/")
fnTstLabels <- paste(pathToDataSet, folderTestData, "y_test.txt", sep="/")
fnTstSubj <- paste(pathToDataSet, folderTestData, "subject_test.txt", sep="/")

featureNames <- fread(fnFeatures)[,V2]
selectedFeatures <- (featureNames %like% "mean") | (featureNames %like% "std")
selectedFeaturesNames <- featureNames[selectedFeatures]

activityLabels <- fread(fnActivities)
setnames(activityLabels, c("activity","activity-label"))
setkey(activityLabels, "activity")

dataSetFldWidths <- rep(16, 561)
dataSetColClasses <- rep(class(numeric(0)), 561)

readUCIDataSet <- function(fileName, fnLabels, fnSubj) {
#  dataSet0 <- read.fwf(fileName, dataSetFldWidths, buffersize=64, colClasses = dataSetColClasses)
  dataSet0 <- laf_open_fwf(fileName, dataSetColClasses, dataSetFldWidths)
  dataSet <- dataSet0[, selectedFeatures]
  rm(dataSet0)
  names(dataSet) <- selectedFeaturesNames
  
  activities <- fread(fnLabels)
  setnames(activities, c("activity"))
  
  dataSet$activity <- activityLabels[activities]$"activity-label"
  
  dataSet$subject <- fread(fnSubj)$V1

  dataSet
}

 rbindlist(list(readUCIDataSet(fnTrnData, fnTrnLabels, fnTrnSubj),readUCIDataSet(fnTstData, fnTstLabels, fnTstSubj)))

}

dtAllData <- load_data_set()
rm(load_data_set)

tidyGroups <- dtAllData %>% group_by(activity,subject) %>% summarise_each(funs(mean))
tidyActivity <- select(dtAllData, -(subject)) %>% group_by(activity) %>% summarise_each(funs(mean))
tidySubject <- select(dtAllData, -(activity)) %>% group_by(subject) %>% summarise_each(funs(mean))

tidyData <- rbindlist(list(tidyGroups,tidyActivity,tidySubject), use.names=T, fill=T)
rm(tidyGroups,tidyActivity,tidySubject)

setnames(tidyData, paste("avg",names(tidyData), sep="-"))
setnames(tidyData, c("avg-activity","avg-subject"), c("activity","subject"))

