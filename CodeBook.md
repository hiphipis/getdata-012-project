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


## Input data
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



## Data transformations

## Tidy data set
