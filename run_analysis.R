# The next few lines describe the steps that have to be made:
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.
#-----------------------------------------------------------------------------

######
# First, we load the necessary extra 
# packages (installing it if it isn't)
######----------------------------------
if (!require("reshape2")) {
  install.packages("reshape2")
}
library(reshape2)

######
# We extract the necessary files
######----------------------------------

## Common files
features <- read.table("./UCI HAR Dataset/features.txt")
# dim(features)
# [1] 561   2
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
# dim(activity_labels)
# [1] 6 2

## Test files
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
# dim(test_set)
# [1] 2947  561
test_label <- read.table("./UCI HAR Dataset/test/y_test.txt")
# dim(test_label)
# [1] 2947    1
test_subj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# dim(test_subj)
# [1] 2947    1

## Train files
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
# dim(train_set)
# [1] 7352  561
train_label <- read.table("./UCI HAR Dataset/train/y_train.txt")
# dim(train_label)
# [1] 7352    1
train_subj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# dim(train_subj)
# [1] 7352    1


######
# We arrange correctly the test and
# train datasets separately
######----------------------------------
testDataset <- test_set
colnames(testDataset) <- gsub("-", "_", features[,2])
testDataset$subjectID <- test_subj[[1]]
testDataset$activity <- as.factor(tolower(gsub("_", " ", activity_labels[test_label[[1]], 2])))
testDataset$group <- as.factor("test")

trainDataset <- train_set
colnames(trainDataset) <- gsub("-", "_", features[,2])
trainDataset$subjectID <- train_subj[[1]]
trainDataset$activity <- as.factor(tolower(gsub("_", " ", activity_labels[train_label[[1]], 2])))
trainDataset$group <- as.factor("train")

######
# We merge the test and train datasets
# into one only dataset with all features
######----------------------------------
completeDataset <- rbind(testDataset, trainDataset)


######
# We keep only the information that
# is necessary to us
######----------------------------------
meanStdColIndexs <- grep("(mean\\(\\)|std\\(\\))", colnames(completeDataset))
datasetMeanStd <- completeDataset[,c("subjectID", "activity", "group", colnames(completeDataset)[meanStdColIndexs])]
colnames(datasetMeanStd) <- gsub("\\(\\)","",colnames(datasetMeanStd))

######
# Finally, we create the wanted dataset
# with the average an the selected fields
# for each subject and activity
######----------------------------------
meltData <- melt(datasetMeanStd, id = c("subjectID", "activity", "group"), mesure.vars = colnames(datasetMeanStd)[4:69])
tidyMeanStdData <- dcast(meltData, subjectID + activity + group ~ variable, mean)

## Save the dataset into a file
write.table(tidyMeanStdData, file = "./tidy_mean_std_average_data.txt", row.name=FALSE)
