
Repository for the Getting and Cleaning Data Course Project
===========================================================

In here you can find:

- **`CodeBook.md`**: A code book that describes the variables, the data, and any
transformations or work that has been performed to clean up the data

- **`run_analysis.R`**: R script that does the following:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the
     average of each variable for each activity and each subject.
  6. Stores the resultant dataset into the `tidy_mean_std_average_data.txt` file.
  
- **`tidy_mean_std_average_data.txt`**: The dataset with the desired information detailed in
the assignment.
  The information is extracted from here: [Project data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
  And the results are obtained executing the R script `run_analysis.R`.
  You can see more information about the stored data inside the `CodeBook.md` file.
  
  To load the dataset into your R session execute the following command, within the
  directory where the file is stored:

  ```
  data <- read.table("./tidy_mean_std_average_data.txt", header = TRUE)
  ```

- **`UCI HAR Dataset`**: The original files from the experiment.