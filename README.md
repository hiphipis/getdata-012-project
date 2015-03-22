# Purpose of repository
This repository contains scripts created by me for the project on the "Getting and Cleaning Data" on the Coursera site.

# Description
The goal of the project is to prepare tidy data that can be used for later analysis. 
It is required to submit as the results of this project: 
* a tidy data set, 
* a link to a Github repository with your script for performing the analysis, and 
* a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
* a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 
* one R script called run_analysis.R 

## Tidy data set
Tidy data set has been written to the file by using
> write.table(tidyData, "tidy_data.txt", use.names=F)
and is included in the repository subfolder _data_ . For the description of data set see CodeBook.md

## Link to Github repository
Link to this repository will be submitted via Coursera site.

## Code book
Code book is included into this repository as separate file CodeBook.md

## README.md
This file

## R script
Single R script called run_analysis.R included in the root of this repository and performs following steps:
*    Merges the training and the test sets to create one data set.
*    Extracts only the measurements on the mean and standard deviation for each measurement. 
*    Uses descriptive activity names to name the activities in the data set
*    Appropriately labels the data set with descriptive variable names. 
*    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
Note - export of tidy data set to file is *not* part of this script and is performed as command entered on the R shell prompt.

To run script you should get source data set
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and unzip it into the same folder as script file. You should get folder named *UCI HAR Dataset* and subfolders for test and training data - this the default layout script expects.
If you have different layout, then you should update script variables named
'''
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
'''

For the detailed description of transformations please see CodeBook.md
