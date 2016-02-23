library(dplyr)

if(!file.exists("data")) {
  dir.create("data")
}

# Download the ZIP file from the website
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(fileURL, temp)

# Unzip the data file and put its contents in the data folder
unzip(temp, exdir= "data")

# Remove the temporary file storing the ZIP file
unlink(temp)
rm(temp)

# Read in the activity labels
activityLabels <- read.table("data\\UCI HAR Dataset\\activity_labels.txt")

# Read in the feature labels
featureLabels <- read.table("data\\UCI HAR Dataset\\features.txt")

# Read in the data and activity labels for the training and test datasets
trainData <- read.table("data\\UCI HAR Dataset\\train\\X_train.txt")
trainLabels <- read.table("data\\UCI HAR Dataset\\train\\y_train.txt")
testData <- read.table("data\\UCI HAR Dataset\\test\\X_test.txt")
testLabels <- read.table("data\\UCI HAR Dataset\\test\\y_test.txt")

# Read in the subjects for the training and test datasets
trainSubjects <- read.table("data\\UCI HAR Dataset\\train\\subject_train.txt")
testSubjects <- read.table("data\\UCI HAR Dataset\\test\\subject_test.txt")

# Merge the training and the test datasets
mergedData <- rbind(trainData, testData)
mergedLabels <- rbind(trainLabels, testLabels)
mergedSubjects <- rbind(trainSubjects, testSubjects)

# Remove the separate training and test datasets
rm(trainData, testData, trainLabels, testLabels, trainSubjects, testSubjects)


# Set the feature labels to the variable names of the 561 measurements
names(mergedData) <- featureLabels[,2]

# Set the activity observations to the descriptive names in activityLabels
mergedLabels <- lapply(mergedLabels, function(n){activityLabels[n,2]})

# Extract the mean() and std() measurements from the merged dataset
extractedIndices <- grep("mean\\(\\)|std\\(\\)",featureLabels[,2])
extractedData <- mergedData[,extractedIndices]

# Add activity info to the extracted data
names(mergedLabels) <- "activity"
extractedData <- cbind(mergedLabels, extractedData)

# Add subject info to the extracted data
names(mergedSubjects) <- "subject"
extractedData <- cbind(mergedSubjects, extractedData)

# Remove non-alphabet characters from the variable names
names(extractedData) <- gsub("-","_",names(extractedData))
names(extractedData) <- gsub("\\(\\)","",names(extractedData))

# Group by both subject and activity
groupedData <- group_by(extractedData, subject, activity)

# Get the names of the extracted measurement variables
extractedVarNames <- names(groupedData)[-(1:2)]

# Take the average of all measurements for a given subject/activity pair
# and store them in a new data frame. Couldn't think of a way to automate
# this using summarize, so I input all the measurements by hand.
newData <- summarize(groupedData, mean(tBodyAcc_mean_X), mean(tBodyAcc_mean_Y),
                      mean(tBodyAcc_mean_Z), mean(tBodyAcc_std_X),
                      mean(tBodyAcc_std_Y), mean(tBodyAcc_std_Z),
                      mean(tGravityAcc_mean_X), mean(tGravityAcc_mean_Y),
                      mean(tGravityAcc_mean_Z), mean(tGravityAcc_std_X),
                      mean(tGravityAcc_std_Y), mean(tGravityAcc_std_Z),
                      mean(tBodyAccJerk_mean_X), mean(tBodyAccJerk_mean_Y),      
                      mean(tBodyAccJerk_mean_Z), mean(tBodyAccJerk_std_X),
                      mean(tBodyAccJerk_std_Y), mean(tBodyAccJerk_std_Z),
                      mean(tBodyGyro_mean_X), mean(tBodyGyro_mean_Y),
                      mean(tBodyGyro_mean_Z), mean(tBodyGyro_std_X),
                      mean(tBodyGyro_std_Y), mean(tBodyGyro_std_Z),
                      mean(tBodyGyroJerk_mean_X), mean(tBodyGyroJerk_mean_Y),
                      mean(tBodyGyroJerk_mean_Z), mean(tBodyGyroJerk_std_X),
                      mean(tBodyGyroJerk_std_Y), mean(tBodyGyroJerk_std_Z),
                      mean(tBodyAccMag_mean), mean(tBodyAccMag_std),          
                      mean(tGravityAccMag_mean), mean(tGravityAccMag_std),       
                      mean(tBodyAccJerkMag_mean), mean(tBodyAccJerkMag_std),      
                      mean(tBodyGyroMag_mean), mean(tBodyGyroMag_std),         
                      mean(tBodyGyroJerkMag_mean), mean(tBodyGyroJerkMag_std),     
                      mean(fBodyAcc_mean_X), mean(fBodyAcc_mean_Y),          
                      mean(fBodyAcc_mean_Z), mean(fBodyAcc_std_X),           
                      mean(fBodyAcc_std_Y), mean(fBodyAcc_std_Z),           
                      mean(fBodyAccJerk_mean_X), mean(fBodyAccJerk_mean_Y),      
                      mean(fBodyAccJerk_mean_Z), mean(fBodyAccJerk_std_X),       
                      mean(fBodyAccJerk_std_Y), mean(fBodyAccJerk_std_Z),       
                      mean(fBodyGyro_mean_X), mean(fBodyGyro_mean_Y),         
                      mean(fBodyGyro_mean_Z), mean(fBodyGyro_std_X),          
                      mean(fBodyGyro_std_Y), mean(fBodyGyro_std_Z),          
                      mean(fBodyAccMag_mean), mean(fBodyAccMag_std),          
                      mean(fBodyBodyAccJerkMag_mean), mean(fBodyBodyAccJerkMag_std),  
                      mean(fBodyBodyGyroMag_mean), mean(fBodyBodyGyroMag_std),     
                      mean(fBodyBodyGyroJerkMag_mean), mean(fBodyBodyGyroJerkMag_std))

# Return the variable names to the original format,
# but add "-TrialAvg" at the end
names(newData) <- gsub("mean\\(", "", names(newData))
names(newData) <- gsub("\\)", "", names(newData))

names(newData) <- gsub("mean", "mean\\(\\)", names(newData))
names(newData) <- gsub("std", "std\\(\\)", names(newData))

names(newData) <- gsub("_", "-", names(newData))
names(newData)[-(1:2)] <- paste(names(newData)[-(1:2)], "-TrialAvg", sep= "")

# Write the new data frame to file "Variable_Averages_Per_Subject_and_Activity.txt"
write.table(newData, file= "Variable_Averages_Per_Subject_and_Activity.txt", row.names= FALSE)