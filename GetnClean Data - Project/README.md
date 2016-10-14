#README
### for 'Getting and Cleaning Data' course project
### by Omer Yavin

The project serves to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

##Files:
- 'run_analysis.R': The script written to clean and tidy the data as requested.
- 'avrgTidyData.txt': Final tidy data, as requested.
- 'Codebook.md': Further description of the data, and the processing method.

##Remarks:
- When the script is run, it assumes the working direcotry holds the root folder of an already extracted zip file. Explicitly - one folder up from 'UCI HAR Dataset'.
- To read the tidy data file to R and maintain the same exact structure as the dataframe from which it was saved, the following command should be used: meanData<-read.csv("avrgTidyData.txt",sep = "",header = T,check.names = F).
	Not using check.names=F will result in slightly manipulated headers for the columns.