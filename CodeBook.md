# Objectives
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data used for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Main objective for the project is to create one R script called run_analysis.R that does the following:
*    Merges the training and the test sets to create one data set.
*    Extracts only the measurements on the mean and standard deviation for each measurement. 
*    Uses descriptive activity names to name the activities in the data set
*    Appropriately labels the data set with descriptive variable names. 
*    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Description of run_analysis.R

Script uses following libraries:
```
library(data.table)
library(LaF)
library(dplyr)
```

To scope variables used for processing definition of function 
>load_data_set <- function () { ... }

is used.
Following variables allow to adjust for different folder layout:
```
pathToDataSet <- "./UCI HAR Dataset"
folderTrainData <- "train"
folderTestData <- "test"
```

Then block of calculated file names variables prefixed with **fn** defines actual input file names:
```
fnFeatures 
fnActivities 
fnTrnData 
fnTrnLabels 
fnTrnSubj
fnTstData
fnTstLabels
fnTstSubj
``` 
Train data set files have **Trn** in their name; test files have **Tst** correspondingly.

## Input data and preparation
**UCI HAR Dataset** includes the following files (as described in data set README.txt):
* 'README.txt': Description of dataset.
* 'features_info.txt': Describes variables used on the feature (measurement) vector.
* 'features.txt': List of all features (or variables) - to be used as column names.
* 'activity_labels.txt': Links the class labels with their activity name - to be used as map from activity code to symbolic names.
* 'train/X_train.txt': Training set - actual measurements without headers and activity and subject columns.
* 'train/y_train.txt': Training labels - activity codes for the each row of neasurement; to be joined with measurements data.
* 'test/X_test.txt': Test set - same as training set, see above.
* 'test/y_test.txt': Test labels - same as training set, see above.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. To be joined with measurements data.

Other files from data set are **not** used (y and z axis too):
* 'train/Inertial Signals/total_acc_x_train.txt'
* 'train/Inertial Signals/body_acc_x_train.txt'
* 'train/Inertial Signals/body_gyro_x_train.txt'
* 'test/Inertial Signals/total_acc_x_test.txt'
* 'test/Inertial Signals/body_acc_x_test.txt'
* 'test/Inertial Signals/body_gyro_x_test.txt'

First of all names of measurements and map of activity codes to their names are loaded into **featureNames** variable.
Then map and corresponding list of names containing "mean" or "std" is created:
```
1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
41 tGravityAcc-mean()-X
42 tGravityAcc-mean()-Y
43 tGravityAcc-mean()-Z
44 tGravityAcc-std()-X
45 tGravityAcc-std()-Y
46 tGravityAcc-std()-Z
.... #67 more measurements variables names to be used
```

Next map of activity codes to their names are loaded into **activityLabels** variable and indexed by activity code.

## Read of measurement data
Read of measurement data is performed by using inner function
> readUCIDataSet <- function(fileName, fnLabels, fnSubj) { ... }

Function takes three parameters:
* fileName - path to measurement data file
* fnLabels - path to activity data file
* fnSubj - path to subject data file

To get fast read of fixed format data laf_open_fwf() is used, feature names assigned to columns and second dataframe with only needed features (columns) is created by subsetting.
Then activity data read and after mapping via **activityLabels** added to the dataframe of data set.
Lastly subject data is read and added to the dataframe. 

Training and test data sets are read separately, merged by using rbindlist(...) and returned as single dataframe as a result of execution of load_data_set().
 
## Tidy data set
Tidy data set is created by grouping and summarising original data set:
```
tidyGroups <- dtAllData %>% group_by(activity,subject) %>% summarise_each(funs(mean))
tidyActivity <- select(dtAllData, -(subject)) %>% group_by(activity) %>% summarise_each(funs(mean))
tidySubject <- select(dtAllData, -(activity)) %>% group_by(subject) %>% summarise_each(funs(mean))
```

As a result three datasets are produced:
* tidyGroups: contains averages calculated by grouping measurements by (activity, subject) pairs
* tidyActivity: contains averages calculated by grouping measurements only by activity
* tidySubject: contains averages calculated by grouping measurements only by subject

Last two data sets have no subject and activity data - it will be replaced (filled in) by NA's.
All three tidy data sets are merged and NA's added to the missing values.
Lastly, all column names in the tidy data set, except activity and subject, get new names by prefixing original names with 'avg-':
```
avg-tBodyAcc-mean()-X
avg-tBodyAcc-mean()-Y
avg-tBodyAcc-mean()-Z
avg-tBodyAcc-std()-X
avg-tBodyAcc-std()-Y
avg-tBodyAcc-std()-Z
...
```

## Results

* **dtAllData** - train and test data set mean and standard deviation measurement values with subject and activity values
* **tidyData** - averaged measurement values for groups { (activity, subject); (activity); (subject) }
 