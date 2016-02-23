README: Getting and Cleaning Data Course Project

Written using RStudio Version 0.99.878, running on an Intel Core i5-3210M processor with Windows 10 Home 64-bit

This analysis script (run_analysis.r) takes data from the Human Activity Recognition Using Smartphones Dataset Version 1.0,
located at 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

which contains accelerometer/gyroscope data from 30 subjects performing 6 activities each.

The script first downloads and unzips the data into a data folder located in the working directory. It then aggregates 
the normalized training and testing datasets (located in \data\UCI HAR Dataset\test\X_test.txt and 
\data\UCI HAR Dataset\test\X_test.txt) and extracts the mean() and std() values for each measurement.
After combining the mean() and std() values with the subject and activity information, the script then
averages each mean() and std() value for every combination of subject and activity. It then appends "-TrialAvg"
to each measurement variable name to reflect the average over trials.

Finally, the script writes the output using write.table() to "Variable_Averages_Per_Subject_and_Activity.txt"
in the working directory.

To read the output tidy dataset into R, put the .txt file in your working directory and use the commands

new_dataset <- read.table("Variable_Averages_Per_Subject_and_Activity.txt", header= TRUE)
View(new_dataset)

from the R console.