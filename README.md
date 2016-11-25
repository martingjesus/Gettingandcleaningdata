# Gettingandcleaningdata

The script 'run_analysis.R' in this repository will create a text file 'TidyDatasetMeans.txt' from a dataset downloaded 
from 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

The dataset represents data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
'http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones'

The script performs several steps to tidy up the data and create the new dataset "TidyDatasetMeans.txt":

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


A detailed description of the variables can be found in CodeBook.md. The basic naming convention is:

Mean{timeOrFreq}{measurement}{meanOrStd}{XYZ}

Where timeOrFreq is either Time or Frequency, indicating whether the measurement comes from the time or frequency domain, 
measurement is one of the original measurement features, meanOrStd is either Mean or StdDev, indicating whether the measurement 
was a mean or standard deviation variable, and XYZ is X, Y, or Z, indicating the axis along which the measurement was taken, or nothing, 
for magnitude measurements.