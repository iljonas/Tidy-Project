library(dplyr)
library(tidyr)
library(reshape2)

combineTables_inSet <- function(setID_path, setX_path, setY_path, setType){
     
     setID <- read.table(setID_path)
     setX <- read.table(setX_path)
     setY <- read.table(setY_path)
     
     colnames(setID) <- "SubjectID"
     colnames(setX) <- feats[[2]]
     
     setID$Set <- setType
     setID$ClassLabel <- setY$V1
     for (i in 1:6){
          setID[names(setX[i])] <- setX[i]}
     
     set_act <- merge(setID, activity_labels, all = TRUE)
     set_act <- set_act[c(2:3,1,10,4:9)]
     
     set_sep <- set_act %>%
          melt(id.vars = names(set_act)[1:4], measure.vars = names(set_act)[5:10], value.name = "MeasurementValue") %>%
          separate(col = variable, into = c("SignalSource", "Function", "Axis")) %>%
          select(-ClassLabel)
     return(set_sep)
}

setwd("C:/Users/Isaac/Documents/Coursera Files")

#download and unzip the archive
zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipDest <- "./tidyproject.zip"
download.file(zipURL, zipDest)
unzip(zipDest, exdir="./tidyproject")

setwd("./tidyproject")

#Paths to data needed by both sets
activity_labels_path <- "./UCI HAR Dataset/activity_labels.txt"
feats_path <- "./UCI HAR Dataset/features.txt"

#Paths to the test set files
testID_path <- "./UCI HAR Dataset/test/subject_test.txt"
testX_path <- "./UCI HAR Dataset/test/X_test.txt"
testY_path <- "./UCI HAR Dataset/test/y_test.txt"

#Paths to the training set files
trainID_path <- "./UCI HAR Dataset/train/subject_train.txt"
trainX_path <- "./UCI HAR Dataset/train/X_train.txt"
trainY_path <- "./UCI HAR Dataset/train/y_train.txt"


activity_labels <- read.table(activity_labels_path, sep = " ", col.names = c("ClassLabel", "ActivityName"))
feats <- read.table(feats_path, sep = " ", col.names = c("FeatureID", "FeatureName"))

test_tidy <- combineTables_inSet(testID_path, testX_path, testY_path, "TEST")
train_tidy <- combineTables_inSet(trainID_path, trainX_path, trainY_path, "TRAIN")

merged_tidy <- merge(test_tidy, train_tidy, all = TRUE)
tbb_tidy <- tibble::as.tibble(merged_tidy)
by_subjAndAct <- group_by(tbb_tidy, SubjectID, ActivityName)
tbb_summary <- summarize(by_subjAndAct, AverageMeasurement = mean(MeasurementValue))

write.csv(tbb_tidy, "./Tidy Detailed Data.txt", row.names = FALSE)
write.csv(tbb_summary, "./Subject and Activity Summary.txt", row.names = FALSE)