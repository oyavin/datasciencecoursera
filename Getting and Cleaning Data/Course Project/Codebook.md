#Codebook
### for 'Getting and Cleaning Data' course project
### by Omer Yavin
Following is a description of the data used, the outcome, and the manipulation implemented in between.

##Data overview
The data used for this project is found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To obtain the data, 30 subjects wearing a Samsung Galaxy S II straped to thier chest, were each instructed to perform the each of the following tasks:
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

For subject performing each task, the built-in phone gyroscope was measured to obtain the following:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 

The data was then divided - 70% of subjects were marked train data and the rest were marked test data.

Further description of the data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Files overview
###The specific files where our data was stored (taken from data README file):
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

###Files used or created during the run:
- 'run_analysis.R': The script written to clean and tidy the data as requested.
- 'avrgTidyData.txt': Final tidy data, as requested.

##Outcome
The final outcome (saved to 'avrgTidyData.txt') holds only the mean of the requested values for each activity, for each subject.

###Final variables include:
subject - subject number
activity - a textual label of the activity recorded
tBodyAcc-mean()-XYZ
tBodyAcc-std()-XYZ
tGravityAcc-mean()-XYZ
tGravityAcc-std()-XYZ
tBodyAccJerk-mean()-XYZ
tBodyAccJerk-std()-XYZ
tBodyGyro-mean()-XYZ
tBodyGyro-std()-XYZ
tBodyGyroJerk-mean()-XYZ
tBodyGyroJerk-std()-XYZ
tBodyAccMag-mean()
tBodyAccMag-std()
tGravityAccMag-mean()
tGravityAccMag-std()
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()
tBodyGyroMag-mean()
tBodyGyroMag-std()
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()
fBodyAcc-mean()-XYZ
fBodyAcc-std()-XYZ
fBodyAccJerk-mean()-XYZ
fBodyAccJerk-std()-XYZ
fBodyGyro-mean()-XYZ
fBodyGyro-std()-XYZ
fBodyAccMag-mean() 
fBodyAccMag-std() 
fBodyBodyAccJerkMag-mean() 
fBodyBodyAccJerkMag-std() 
fBodyBodyGyroMag-mean() 
fBodyBodyGyroMag-std() 
fBodyBodyGyroJerkMag-mean() 
fBodyBodyGyroJerkMag-std()

* XYZ actualy means there are three variables: one for X axis, one for Y axis and one for Z axis.

** These are to my best understanding the desired variables.
** While I realize there are other vaiables with the phrase 'mean' in them, I do not think they fall under the criteria described in the instructions.

##Data cleaning and tidying process

###Step 1: Merges the training and the test sets to create one data set.
- Uses as.data.frame() command to convert x variables.
- Names the columns using the features vector and the colnames() command.
- Adds activity and subject indeces to each data frame by setting to new columns named 'y' an 'subject' accordingly.
- Binds the two data frames (the one obtained from train and the one obtained from test).

###Step 2:Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
- Subsets the desired data using grep() command on the column names to obtain the indeces for the appropriate columns.
*This method was chosen over dplyr::select due to a problem with the column names.

###Step 3: Uses descriptive activity names to name the activities in the data set.
- Uses the value of y as an index for the activities vector to exchange each number for a name.

###Step 4: Appropriately labels the data set with descriptive variable names.
- Since most naming was done neatly up till now, only needs to rename 'y' column to 'activity'.

###Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Melts the dataframe according to subject and activity. This collapes all other variables to two colums, one containing the names of the vaiables, the second containing the values.
- Used dcast() command to apply the mean command to each variable against each pair of subject+activity.
** The melting method came to me from the following blog post: https://www.r-bloggers.com/using-r-quickly-calculating-summary-statistics-from-a-data-frame/
** Searching for a method similar to ddply outside of 'plyr' I found dcast.

#Final step: Use write.table to save the tidy data to file.


##Code variables

###Running the script on my laptop, I kept running into memory problems. For this reason, at the end of the run, only two variables are left in the workspace:
meanData - the final tidy data as requested, which is saved to the file 'avrgTidyData.txt'. For each subject for each activity, one value per variable (the mean of all existing values).
dfData - the tidy data which differentiates from 'meanData' in that it holds several measurements of each variable for each subject for each activity, and not just one.

###Durring the run other variables are created and then erased, only serving as auxilary:
x_train - List. Data read from './train/X_train.txt'. Holds only textual numbers with no labels.
y_train - List. Data read from './train/y_train.txt'. Holds textual indeces, each reffering to the activity recorded in the appropriate row in X_train.
sub_train - List. Data read from './train/subject_train.txt'. Holds textual indeces, each reffering to the subject recorded in the appropriate row in X_train.
x_test - Same as x_train, for test folder.
y_test - Same as y_train, for test folder.
sub_test - Same as sub_train, for test folder.
features - List. Data read from 'features.txt'. Holds the names of the variables measured in X files.
activities - List. Data read from 'activity_labels.txt'. Holds a legend matching between an activity and its in index as it is represented in y files.
df_train - Data frame. A complete, tidy set of the data from train. Combined with df_test to create dfData.
df_test - Data frame. A complete, tidy set of the data from test. Combined with df_train to create dfData.
meltedData - Data frame. Result of melting dfData as an intermediate step towards creating meanData.