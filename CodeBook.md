# Code Book

The data obtained and processed via the attached script were obtained from the
[Human Activity Tracking](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) experiments from the UCI repository, and are the property of:

>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public 
>Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on 
>Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges,
>Belgium 24-26 April 2013.

A detailed description and the background of the experiments can be found in the `README.txt`
and the `features_info.txt` contained in the original file. However, an excerpt from the original
`features_info.txt` is included below in order to better understand the data:

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw 
>signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were 
>captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd 
>order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, 
>the acceleration signal was then separated into body and gravity acceleration signals 
>(tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner 
>frequency of 0.3 Hz. 
>
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain 
>Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these 
>three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag,
>tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
>fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
>(Note the 'f' to indicate frequency domain signals). 
>
>These signals were used to estimate variables of the feature vector for each pattern:  
>'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
>
>tBodyAcc-XYZ
>tGravityAcc-XYZ
>tBodyAccJerk-XYZ
>tBodyGyro-XYZ
>tBodyGyroJerk-XYZ
>tBodyAccMag
>tGravityAccMag
>tBodyAccJerkMag
>tBodyGyroMag
>tBodyGyroJerkMag
>fBodyAcc-XYZ
>fBodyAccJerk-XYZ
>fBodyGyro-XYZ
>fBodyAccMag
>fBodyAccJerkMag
>fBodyGyroMag
>fBodyGyroJerkMag

Of the set of variables that were estimated from these signals listed above only the following
are presented in the data output files of this script: 

>mean(): Mean value
>std(): Standard deviation

There were three additional columns appened to the data to obtain `final_set`:
data_set: data set where the data were obtained from (test or train)
subjects: subject whose data was recorded (1:30)
activity_type: activity that was being performed (WALKING, LAYING, SITTING, STANDING, 
			WALKING DOWNSTAIRS, WALKING UPSTAIRS)
			
Using data from `final_set`, an additonal data set was created that houses the mean values based
on subject and activity - this data set does not containg the `data_set` variable. It determines
the mean on aggregate data from both the `test` and `train` data sets.