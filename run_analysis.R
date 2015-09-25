#Notes:
setwd("/home/florian/Arbeitsfläche/Data Science/Getting Data/Project")

#Download data
#if(!exists("./data")){dir.create("./data")}
#fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl, destfile="data/temp.zip", method="curl")
#Data is in folder ""data" in he working directory

#Manual unzip


################Task 1 ##############################



#Merging Training Data

subjectTrain<-read.csv("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
xTrain<-read.csv("./data/UCI HAR Dataset/train/X_train.txt", sep='', header = FALSE)
yTrain<-read.csv("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)

train<-cbind(subjectTrain, yTrain, xTrain)


#Merging Test Data
subjectTest<-read.csv("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
xTest<-read.csv("./data/UCI HAR Dataset/test/X_test.txt", sep='', header = FALSE)
yTest<-read.csv("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)

test<-cbind(subjectTest, yTest, xTest)

#rbinding Test and Training Data
data<-rbind(train, test)

################ Task 4 ##############################

#Some Variable Naming
library(dplyr)
colnames(data)[1]<-"Subject"
colnames(data)[2]<-"Activity"

#Naming feature variables
##Reading in variable names (features) from txt file
features<-read.csv("./data/UCI HAR Dataset/features.txt", sep='', header=FALSE, stringsAsFactors=FALSE)
variableNames<-features$V2

colnames(data)[3:563]<-variableNames

################ Task 2 ##############################

#Extracts only the measurements on the mean and standard deviation for each measurement,but keeps the subject id and the activity variable . 

data.selected <- data[, grep("Subject|Activity|mean|std", names(data))]


################ Task 3 ##############################
#reading in text file with levels

activityLabels<-read.csv("./data/UCI HAR Dataset/activity_labels.txt", sep='', header=FALSE, stringsAsFactors=FALSE)

#extracting labels and levels into vectors for later use in the factor() command
labels<-activityLabels$V2
levels<-activityLabels$V1

data.selected$Activity<-factor(data.selected$Activity, levels=levels, labels=labels)


################ Task 5 ##############################

grouped_data<-group_by(data.selected, Subject)

summarize(grouped_data, v1=mean(as.numeric("tBodyAcc-mean()-X"), na.rm=TRUE))
summarize(grouped_data$Activity)
