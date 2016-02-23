NOTES:
- Data originates from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- Data in the test and training sets are normalized and bounded in the range [-1, 1]

- Unnormalized acceleration data are found in the "Inertial Signals" folders and are in units of g=9.8 meters/second^2.

- Unnormalized angular velocity data are in units radians/second

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals 
(tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals 
(tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated 
using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
(Note the 'f' to indicate frequency domain signals). 

For each signal, the mean and standard deviation (std) were measured (<<signal>>-mean() and <<signal>>-std()), 
and the data were segregated by subject and activity. All measurements for a given subject and activity were then
averaged to give the <<signal>>-<<statistic>>-TrialAvg measurements

'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Variables Measured
=================

subject: Test subject, ranges from 1 to 30 (30 subjects in total, ranging in age from 19-48 years)

activity: The activity for which the data were collected. 
	1: WALKING, 
	2: WALKING_UPSTAIRS, 
	3: WALKING_DOWNSTAIRS, 
	4: SITTING, 
	5: STANDING, 
	6: LAYING

Time-domain measurements (<<statistic>> is either mean() or std()):

tBodyAcc-XYZ-<<statistic>>-TrialAvg
tGravityAcc-XYZ-<<statistic>>-TrialAvg
tBodyAccJerk-XYZ-<<statistic>>-TrialAvg
tBodyGyro-XYZ-<<statistic>>-TrialAvg
tBodyGyroJerk-XYZ-<<statistic>>-TrialAvg
tBodyAccMag-<<statistic>>-TrialAvg
tGravityAccMag-<<statistic>>-TrialAvg
tBodyAccJerkMag-<<statistic>>-TrialAvg
tBodyGyroMag-<<statistic>>-TrialAvg
tBodyGyroJerkMag-<<statistic>>-TrialAvg

Frequency-domain measurements (<<statistic>> is either mean() or std()):

fBodyAcc-XYZ-<<statistic>>-TrialAvg
fBodyAccJerk-XYZ-<<statistic>>-TrialAvg
fBodyGyro-XYZ-<<statistic>>-TrialAvg
fBodyAccMag-<<statistic>>-TrialAvg
fBodyAccJerkMag-<<statistic>>-TrialAvg
fBodyGyroMag-<<statistic>>-TrialAvg
fBodyGyroJerkMag-<<statistic>>-TrialAvg

