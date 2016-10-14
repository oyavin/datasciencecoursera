## Initialize workspace

# load necessary libraries
library(dplyr)
library(reshape2)
# read data
x_train<-read.csv("./UCI HAR Dataset/train/x_train.txt",sep = "",header = F)
y_train<-read.csv("./UCI HAR Dataset/train/y_train.txt",sep = "",header = F)
sub_train<-read.csv("./UCI HAR Dataset/train/subject_train.txt",sep = "",header = F)
x_test<-read.csv("./UCI HAR Dataset/test/x_test.txt",sep = "",header = F)
y_test<-read.csv("./UCI HAR Dataset/test/y_test.txt",sep = "",header = F)
sub_test<-read.csv("./UCI HAR Dataset/test/subject_test.txt",sep = "",header = F)
features<-read.csv("./UCI HAR Dataset/features.txt",sep = "",header = F)
activities<-read.csv("./UCI HAR Dataset/activity_labels.txt",sep = "",header = F)
# prepare for feature\variable labeling
features<-t(features[,2])


## Step 1: Merges the training and the test sets to create one data set.

# prepare measurements as dataframes
df_train<-as.data.frame(x_train)
df_test<-as.data.frame(x_test)
# name the variables
colnames(df_train)<-features
colnames(df_test)<-features
# add missing data (y, subject labels) to complete dataframe
df_train[,"y"]<-y_train
df_train[,"subject"]<-sub_train
df_test[,"y"]<-y_test
df_test[,"subject"]<-sub_test
# dispose of unnecessary variables in workspace
remove(x_train,y_train,sub_train,x_test,y_test,sub_test,features)
# merge
dfData<-rbind.data.frame(df_train,df_test)
remove(df_train,df_test)


## Step 2: Extracts only the measurements on the mean and standard deviation for each
## measurement.

# including 'y' and 'subject' columns as they are needed further on
dfData<-dfData[,grep("(mean|std)\\(\\)|^y$|^subject$",colnames(dfData))]


## Step 3: Uses descriptive activity names to name the activities in the data set.

# use the value of y as an index for the activities vector to exchange number for name
dfData$y<-activities[dfData$y,2]
remove(activities)


## Step 4: Appropriately labels the data set with descriptive variable names.

# rename 'y' to make it descriptive
dfData<-rename(dfData,activity=y)


## Step 5: From the data set in step 4, creates a second, independent tidy data set with the
## average of each variable for each activity and each subject.

# melt data to prepare it for mean calculation by activity and subject
meltedData<-melt(dfData,id.vars = c("subject","activity"))
meanData<-dcast(meltedData,subject+activity~variable,mean)
remove(meltedData)

## Save a file of the database in the new form obtained
write.table(meanData,"avrgTidyData.txt",row.names = F,quote = F)