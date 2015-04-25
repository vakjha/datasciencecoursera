library(caret) 
library(kernlab) 
library(randomForest) 


setwd("D:/coursera-ds/ml")

# downlaoding and placing the files locally 

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv" 
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv" 
download.file(fileUrl1,destfile="training.csv") 
download.file(fileUrl2,destfile="testing.csv") 

# Prepare files for analysis  
training <- read.csv("./training.csv", na.strings= c("NA",""," ")) 
# clean the data by removing columns with NAs etc 
training_NAs <- apply(training, 2, function(x) {sum(is.na(x))}) 
training_clean <- training[,which(training_NAs == 0)]  
# remove identifier columns such as name, timestamps etc 
training_clean <- training_clean[8:length(training_clean)]  

# Apply same transformations to the the testing data
test <- read.csv("./testing.csv", na.strings= c("NA",""," ")) 
test_NAs <- apply(test, 2, function(x) {sum(is.na(x))}) 
test_clean <- test[,which(test_NAs == 0)] 
test_clean <- test_clean[8:length(test_clean)] 

# split the cleaned testing data into training and cross validation 
inTrain <- createDataPartition(y = training_clean$classe, p = 0.7, list = FALSE) 
training <- training_clean[inTrain, ] 
crossval <- training_clean[-inTrain, ]  

# apply random forest model  
model <- randomForest(classe ~ ., data = training) 
 
# crossvalidate the model using the remaining 30% of data 
predictCrossVal <- predict(model, crossval) 
confusionMatrix(crossval$classe, predictCrossVal)  

# predict the classes of the test set 
predictTest <- predict(model,test_clean) 
answers<- predictTest
answers

# Use PML write function to generate output files  

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}
