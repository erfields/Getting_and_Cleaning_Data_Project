Getting_and_Cleaning_Data_Project
=================================
## Details of the Project

The run_analysis.R script in this repository does the following:

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive activity names.
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Steps the Take Before Executing the Script
1. Download the UCI HAR Dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and unzip it to a directory on your local machine.
2. Copy run_analysis.R to the same directory where the UCI HAR Dataset directory exists.
3. Set your working directory in R to the same directory where the UCI HAR Dataset and the run_analysis.R script exists.

##How to Execute the Script
From the R prompt, run:
> source(run_analysis.R)
> run_analysis()
 
##Expected Output of the Script
The run_analysis.R script will create a file in your working directory called project_tidy_data.txt that contains a tidy data set of the test and train
data in the UCI HAR Dataset directory.
