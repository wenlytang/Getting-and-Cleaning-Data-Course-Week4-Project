library("data.table")
library("dplyr")
library("reshape2")

##Load train data
subjectID_train <- read.table("subject_train.txt")
data_train <- read.table("x_train.txt")
activityID_train <- read.table("y_train.txt")

##Load test data
subjectID_test <- read.table("subject_test.txt")
data_test <- read.table("x_test.txt")
activityID_test <- read.table("y_test.txt")

##Load activity labels
activity_labels <- read.table("activity_labels.txt")

##Load features/column names
features <- read.table("features.txt")

#Combine subjectID and activityID with data for both train and test
completedata_train <- cbind(subjectID_train, activityID_train, data_train)
completedata_test <- cbind(subjectID_test, activityID_test, data_test)

##Merge train and test data sets, and rename columns
alldata <- rbind(completedata_train, completedata_test)
colnames(alldata) <- c("SubjectID", "ActivityID", as.character(features[ ,2]))

##Extract measurements on the mean and standard deviation
extract_features <- grep("[Mm]ean|[Ss]td", colnames(alldata)) 
alldata_meanstd <- alldata[ ,c(1,2,extract_features)]

##Replace activityIDs with descriptive activity names
alldata_meanstd$ActivityID <- as.character(alldata_meanstd$ActivityID)
for (i in 1:6){alldata_meanstd$ActivityID[alldata_meanstd$ActivityID == i] <- as.character(activity_labels[i,2])}

##Label data set with descriptive variable names
names(alldata_meanstd) ##Take a look at all of the variable names
names(alldata_meanstd) <- gsub("^t", "Time", names(alldata_meanstd))
names(alldata_meanstd) <- gsub("^f", "Frequency", names(alldata_meanstd))
names(alldata_meanstd) <- gsub("Acc", "Accelerometer", names(alldata_meanstd))
names(alldata_meanstd) <- gsub("Gyro", "Gyroscope", names(alldata_meanstd))
names(alldata_meanstd) <- gsub("Mag", "Magnitude", names(alldata_meanstd))
names(alldata_meanstd) <- gsub("std", "StandardDeviation", names(alldata_meanstd))
names(alldata_meanstd) <- gsub("arCoeff", "AutoregressionCoefficient", names(alldata_meanstd))
names(alldata_meanstd) <- gsub("meanFreq", "MeanFrequency", names(alldata_meanstd))

##Create a new tidy data set with the average of each variable for each activity and each subject
meltalldata_meanstd <- melt(alldata_meanstd, id = c("SubjectID", "ActivityID"))
tidy_data <- dcast(meltalldata_meanstd, SubjectID + ActivityID ~ variable, mean)
write.table(tidy_data, file = ".\\tidy_data.txt", row.names = FALSE)
