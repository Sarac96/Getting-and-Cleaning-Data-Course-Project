# Getting-and-Cleaning-Data-Course-Project

The aim of the script is to download and process the data from the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), so as to create a tidy dataset.

## Data used ##
The files used are the following:
* features.txt - Description of the variables (features) involved
* activitynames.txt - Description of the codes used for the activity names (Y variable)
* X_train.txt - measurement of the features in the training set
* Y_train.txt - activity corresponding to the features in the training set
* subject_train.txt - subject in the training set
* X_test.txt - measurement of the features in the test set
* Y_test.txt - activity corresponding to the features in the test set
* subject_test.txt - subject in the test set

## Transformations applied ##
The transformation applied through the script (run_analysis.R) are aimed at:
* Merging the training and the test sets to create one data set.
* Extracting only the measurements on the mean and standard deviation for each measurement.
* Using  descriptive activity names to name the activities in the data set
* Appropriately labelling the data set with descriptive variable names.
* From the data creating a second, independent tidy data set with the average of each variable for each activity and each subject.

## Final Output ##
Tidy dataset with the mean of all features per activity and subject
