# Data Tranformations 

##Load test and training sets and the activities
*fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
*The data set has been stored in the UCI HAR Dataset/ directory.
*The file is being extracted out of this location and stored locallly in the working directory manually before the R code starts 

##read.table is used to load the data to R environment for the data, the activities and the subject of both test and training datasets.

testx <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testy <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainx <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

## Appropriately labels the data set with descriptive activity names

activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
testy$V1 <- factor(testy$V1,levels=activities$V1,labels=activities$V2)
trainy$V1 <- factor(trainy$V1,levels=activities$V1,labels=activities$V2)


*Each data frame of the data set is labeled - using the features.txt - with the information about the variables used on the feature. 
*The Activity and Subject columns are also named properly before merging them to the test and train dataset.

features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(testx)<-features$V2
colnames(trainx)<-features$V2
colnames(testy)<-c("Activity")
colnames(trainy)<-c("Activity")
colnames(test_subject)<-c("Subject")
colnames(train_subject)<-c("Subject")

## Merge test and training sets into one data set, including the activities

* The Activity and Subject columns are appended to the test and train data frames, and then are both merged in the merged data frame.

testx<-cbind(testx,testy)
testx<-cbind(testx,test_subject)
trainx<-cbind(trainx,trainy)
trainx<-cbind(trainx,train_subject)
mergeddata<-rbind(testx,trainx)


## Extract only the measurements on the mean and standard deviation for each measurement

* mean() and sd() are used against bigData via sapply() to extract the requested measurements.
* These measurements are then written to a text file for consumption as per the assignment requirements.


mergeddata_mean<-sapply(mergeddata,mean,na.rm=TRUE)
mergeddata_sd<-sapply(mergeddata,sd,na.rm=TRUE)

merged <- data.table(mergeddata)
tidydata<-merged[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidydata,file="tidydata.txt",sep=",",row.names = FALSE)