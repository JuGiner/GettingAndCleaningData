
What this CodeBook describes
============================

Here in this CodeBook you can find the necessary information to understand the variables and 
data stored in the dataset inside the `tidy_mean_std_average_data.txt` file. 

In addition, the transformations and work that was performed to clean up the data from the 
original source will be explained as well.


Information about the data
==========================

The data used to create the dataset can be accessed following this 
[link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
and is the resultant data from the accelerometers from the Samsung Galaxy S smartphone. To 
know more about that experiment you can visit its 
[site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

In the originals files you can obtain the information in detail related to each of the
different features extracted from the accelerometers from the smartphone.

In our dataset, only the **mean** (_mean_) and **standard deviation** (_std_) from each
feature is stored. 

It is worth mentioning that in our project, the _meanFreq_ was **not** considered as
information to be extracted because it is a weighted average of the frequency components as
oposed to the global mean value.

For each row in the dataset we have the following fields:

* __Subject ID__: 
  - the unique identificator of the subject that did the experiment. It has the values in 
  the range between 1 and 30.
  - named `subjectID`

* __Activity__:
  - the activity realized by the subject. They are stored in a descriptive way and can have
  one of the following values: "laying", "sitting", "standing", "walking", 
  "walking downstairs" and "walking uptairs".
  - named `activity`

* __Group__:
  - the group from where subject belonged. It can be from the "test" group or the "train"
  group, and it can have one of those two values.
  - named `group`
  
* __Features__:
  - the rest of the fields correpond to the features mean and standard deviation values for
  each activity and subject.
  - the features are the ones described in the file `features_info.txt` (from the original
  data of the experiment [features info](./UCI\ HAR\ Dataset/features_info.txt)). 
    The different features that were extracted are the following:
    - "tBodyAcc-XYZ"
    - "tGravityAcc-XYZ" 
    - "tBodyAccJerk-XYZ" 
    - "tBodyGyro-XYZ"
    - "tBodyGyroJerk-XYZ"
    - "tBodyAccMag"
    - "tGravityAccMag"
    - "tBodyAccJerkMag"
    - "tBodyGyroMag"
    - "tBodyGyroJerkMag"
    - "fBodyAcc-XYZ"
    - "fBodyAccJerk-XYZ"
    - "fBodyGyro-XYZ"
    - "fBodyAccMag"
    - "fBodyAccJerkMag"
    - "fBodyGyroMag"
    - "fBodyGyroJerkMag"
  - named `<name>_<statistic>[_<coord>]`, where:
    - `<name>` is the name of the feature (for example "tBodyAcc"), 
    - `<statistic>` is the statistic that was performed ("_mean_" or "_std_")
    - `<coord>` is the coordinate in the three dimensions in the case that they exist (can 
      be "X", "Y" or "Z")
    - An example is `tBodyAcc_mean_X`, that corresponds to the "mean" of feature "tBodyAcc"
      for the coordinate "X"


Steps to clean up the data
==========================

The steps used to clean up the data are the steps permorfed in the R script
[`run_analysis.R`](run_analysis.R).

The resultant file with the dataset can be loaded into your R session executing the
following command, within the directory where the file is stored:

```
data <- read.table("./tidy_mean_std_average_data.txt", header = TRUE)
```

The code in the R script follows the following steps:

1. Load the necessary extra R packages needed to manipulate the data, and installing
them before if they were'nt already installed.

2. Extract the necessary files from the original provided data. This files are:
  - `features.txt`: with the labels of the different features extracted in the experiment.
  - `activity_labels.txt`: with the labels of the 6 activities done by the subjects.
  - `X_test.txt`: with the actual statistical data of every feature from each subject of
  the test group and activity.
  - `y_test.txt`: with the correspondence between the rows in the `X_test.txt` and the 
  activity conducted.
  - `subject_test.txt`: with the correspondence between the rows in the `X_test.txt` and
  the subject who produced it.
  - `X_train.txt`: with the actual statistical data of every feature from each subject of
  the train group and activity.
  - `y_train.txt`: with the correspondence between the rows in the `X_train.txt` and the 
  activity conducted.
  - `subject_train.txt`: with the correspondence between the rows in the `X_train.txt` and
  the subject who produced it.
  
3. Arrange correctly the test and train datasets separately
  In this step the datasets "test" and "train" are manipulated to have the following
  advantatges:
  - column names that represent the name of the feature that are stored inside. This is
  made by matching the `features` data frame from `features.txt` with the column names of 
  the data frame from `X_test.txt` and `X_train.txt` respectively.
  - a column with the subject id of the subject who produced the data of the row. This is 
  made by matching the `subject_test.txt` and `subject_train.txt` data frames with the 
  new "test" and "train" data frames respectively.
  - a column with the labels of the activities conducted in a descriptive way. This is made
  by matching the `activity_labels.txt` data frame with the "test" and "train" data frames,
  using the `y_test.txt` and `y_train.txt` data frames content.
  
4. Join the "test" and "train" datasets into one only dataset with all the features,
binding the two data frames together

5. Extract only the columns with the `mean` and `std` information from the "complete" 
data frame, into a new data frame (containing also the columns that reference the subject,
activity and group)

6. Create a new tidy data frame with the average of each feature in the last data frame 
created, for each subject and activity

7. Store the dataset into a file
