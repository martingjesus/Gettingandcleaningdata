runAnalysis <- function() {

# Setting up the working directory and dowloading files

setwd("C:/Users/Jesus/Desktop/R/Getting and Cleaning Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "GalaxyAccelerometers")
unzip("GalaxyAccelerometers")

# Reading training and test data and its variables names and merging them into one data frame

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
colnames(X_test) <- as.vector(read.table("UCI HAR Dataset/features.txt", header = FALSE)[,2])
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
colnames(X_train) <- as.vector(read.table("UCI HAR Dataset/features.txt", header = FALSE)[,2])
Data <- rbind(X_train, X_test)

# Extracts only the measurements on the mean and standard deviation (mean() and std()) for each measurement.

Datafilteredint <- grep("(mean|std)\\(\\)", x = colnames(Data))
Datafiltered <- Data[, Datafilteredint]

# Use descriptive activity names to name the activities in the data set.
# Get the activity data and map to nicer names:

yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
yTest  <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
yMerged <- rbind(yTrain, yTest)[, 1]
activityNames <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
activities <- activityNames[yMerged]

# Appropriately label the data set with descriptive variable names.
# Change t to Time, f to Frequency, mean() to Mean and std() to StdDev
# Remove extra dashes and change BodyBody to Body

names(Datafiltered) <- gsub("^t", "Time", names(Datafiltered))
names(Datafiltered) <- gsub("^f", "Frequency", names(Datafiltered))
names(Datafiltered) <- gsub("-mean\\(\\)", "Mean", names(Datafiltered))
names(Datafiltered) <- gsub("-std\\(\\)", "StdDev", names(Datafiltered))
names(Datafiltered) <- gsub("-", "", names(Datafiltered))
names(Datafiltered) <- gsub("BodyBody", "Body", names(Datafiltered))

# Add activities and subject to the data frame with appropiate names
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjectTest  <- read.table("UCI HAR Dataset/test/subject_test.txt")
subjects <- rbind(subjectTrain, subjectTest)[, 1]
TidyData <- cbind(Subject = subjects, Activity = activities, Datafiltered)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)
limitedColMeans <- function(data) { colMeans(data[,-c(1,2)]) }
TidyDatasetMeans <- ddply(TidyData, .(Subject, Activity), limitedColMeans)
names(TidyDatasetMeans)[-c(1,2)] <- paste0("Mean", names(TidyDatasetMeans)[-c(1,2)])
write.table(TidyDatasetMeans, "TidyDatasetMeans.txt", row.names = FALSE)

TidyDadasetMeans

}