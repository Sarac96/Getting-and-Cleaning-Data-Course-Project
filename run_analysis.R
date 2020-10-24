library(data.table)
library(dplyr)
library(tidyr)

# Download files and unzip them
tempfile <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", tempfile)
unzip(tempfile, exdir="data")
file.remove(tempfile)

# Get label names and load the relevant data into R
labels <- fread("data/UCI HAR Dataset/features.txt", col.names = c("nrow", "feature"))
trainingset_X <- fread("data/UCI HAR Dataset/train/X_train.txt", sep=" ", col.names = labels$feature)
testset_X <- fread("data/UCI HAR Dataset/test/X_test.txt", sep=" ", col.names = labels$feature)
trainingset_Y <- fread("data/UCI HAR Dataset/train/Y_train.txt", sep=" ", col.names = "activitycode")
testset_Y <- fread("data/UCI HAR Dataset/test/Y_test.txt", sep=" ", col.names = "activitycode")
subjecttest<- fread("data/UCI HAR Dataset/test/subject_test.txt", sep=" ", col.names = "subject")
subjecttraining <-fread("data/UCI HAR Dataset/train/subject_train.txt", sep=" ", col.names = "subject")
activitynames <- fread("data/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "value"))

#Merge data into one single dataset
trainingset <- cbind(trainingset_Y, subjecttraining, trainingset_X)
testset <- cbind(testset_Y, subjecttest, testset_X)
dtfull <- rbind(trainingset, testset)

# Select only mean and stdev observations
dtsel <- select(dtfull, activitycode, subject, contains(c("mean()", "std()")))
dtsel <- mutate(dtsel, activityname = activitynames$value[match(activitycode,activitynames$code)])
dtsel <- select(dtsel, - activitycode)

# Create tidy dataset and clean colnames
df_tidy <- dtsel %>% group_by(activityname, subject) %>% summarise_all(mean)
colnames(df_tidy) <- gsub("\\()", "", colnames(df_tidy))

# Export tidy dataset
if (!dir.exists("output")) dir.create("output")
write.table(df_tidy,"output/tidy_dataset.txt", row.names = FALSE, na="")
