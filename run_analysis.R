run_analysis <- function() {
    ## This function does the following:
    ## 1.Merges the training and the test sets to create one data set.
    ## 2.Extracts only the measurements on the mean and standard deviation for 
    ## each measurement. 
    ## 3.Uses descriptive activity names to name the activities in the data set
    ## 4.Appropriately labels the data set with descriptive variable names. 
    ## 5.Creates a second, independent tidy data set with the average of each 
    ## variable for each activity and each subject. 
    
    ##check if data.table package is installed and install it if it's not
    if (!("data.table" %in% rownames(installed.packages())))
    {
        install.packages("data.table")
    }
    
    if (!("reshape2" %in% rownames(installed.packages())))
    {
        install.packages("reshape2")
    }
    
    library("data.table")
    library("reshape2")
    
    ##Read activity data
    activity <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                           col.names=c("ActivityID", "ActivityName"))
   
    
    ##Get test and train data column names
    features <- read.table("./UCI HAR Dataset/features.txt", 
                           col.names=c("ColumnID","ColumnName"))
    
    ##Read test data, labels and subject info
    xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
    ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                        col.names = "ActivityID") 
    test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
   
    
    ##Read training data, labels and subject info
    xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt") 
    ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                         col.names = "ActivityID") 
    train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    
    ##Assign test and train data column names
    names(xtest) = features$ColumnName
    names(xtrain) = features$ColumnName
    
    ##Get only the columns that measure mean and standard deviation
    columns_to_remove <- grepl("mean|std", features$ColumnName)
   
    ##Remove columns from test and train data that are not mean of std dev
    xtest = xtest[,columns_to_remove]
    xtrain = xtrain[,columns_to_remove]
    
    ##Assign activity name to ytest data
    ytest$Activity <- activity$ActivityName[ytest$ActivityID]
    ytrain$Activity <- activity$ActivityName[ytrain$ActivityID]
    
    ##Assign Subject column name to subject data
    names(test_subject) = "Subject"
    names(train_subject) = "Subject"
  
    ##Add subject info and activity info to test and train data 
    testdata <- cbind(as.data.table(test_subject), ytest, xtest)
    traindata <- cbind(as.data.table(train_subject), ytrain, xtrain)
    
    ##combine test and train data
    data <- rbind(testdata, traindata)
    
    ##Stack a set of columns into a single column of data
    idvars = c("Subject", "ActivityID", "Activity")
    measurevars = setdiff(colnames(data), idvars)
    mdata = melt(data, id = idvars, measure.vars = measurevars)
    
    ##Get average of each variable for each activity and each subject
    final_data = dcast(mdata, Subject + Activity ~ variable, mean)
    
    ##Write the final data set to file
    write.table(final_data, file = "./project_tidy_data.txt")
    
}