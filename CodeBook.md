## Human Activity Recognition Using Smartphones Dataset
### Data set information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
### Attribute information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
### Original data download path
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
### Data files used for the analysis
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'subject_train.txt' & 'subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
## Steps to clean up the data
### Merges the training and the test sets to create one data set.
1. Load the above 8 files into R. 'subjectID_train', 'data_train', and 'activityID_train' belong to the train data set. 'subjectID_test', 'data_test', 'activityID_test' belong to the test data set. 'activity_labels' stores the name of the 6 activities. 'features' stores the 561 variable/column names. 
2. Combine the subject, data and activity tables into the complete data set respectively for train and test, resulting in 'completedata_train' and 'completedata_test'.
3. Merge the 'completedata_train' and 'completedata_test' into 'alldata', and rename the columns using 'features'. 
### Extracts only the measurements on the mean and standard deviation for each measurement.
1. Create 'extract_features' to capture the position where the column names contain mean and std.
2. Use 'extract_features' to subset alldata and store it in 'alldata_meanstd'.
### Uses descriptive activity names to name the activities in the data set.
1. Set the class of the acivity names to character using as.character.
2. Use control structure if to replace the numeric value with actual activity names, referencing 'activity_labels'.
### Appropriately labels the data set with descriptive variable names.
1. Use gsub function to replace abbreviated variable names with the ones that show full descriptions.
### From the data set in previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
1. Melt 'alldata_meanstd' to 'meltalldata_meanstd', by setting SubjectID and ActivityID as id variable, the rest as measure variable.
2. Use dcast function to reshape the data set into 'tidy_data'.
3. Create new file 'tidy_data.txt' by write.table.
