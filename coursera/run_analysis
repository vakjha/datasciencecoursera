#load libaraies 
library(data.table)

#load test and training sets and the activities
testx <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testy <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainx <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
#naming activites in the data 
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
testy$V1 <- factor(testy$V1,levels=activities$V1,labels=activities$V2)
trainy$V1 <- factor(trainy$V1,levels=activities$V1,labels=activities$V2)
#labeling data with activity names 
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(testx)<-features$V2
colnames(trainx)<-features$V2
colnames(testy)<-c("Activity")
colnames(trainy)<-c("Activity")
colnames(test_subject)<-c("Subject")
colnames(train_subject)<-c("Subject")
#merge test and training data 
testx<-cbind(testx,testy)
testx<-cbind(testx,test_subject)
trainx<-cbind(trainx,trainy)
trainx<-cbind(trainx,train_subject)
mergeddata<-rbind(testx,trainx)
#measurements on the mean and standard devations 
mergeddata_mean<-sapply(mergeddata,mean,na.rm=TRUE)
mergeddata_sd<-sapply(mergeddata,sd,na.rm=TRUE)
# Create a second tidy dataset for the assignment 
merged <- data.table(mergeddata)
tidydata<-merged[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidydata,file="tidydata.txt",sep=",",row.names = FALSE)
write.table(tidydata,file="tidydata.csv",sep=",",row.names = FALSE)


