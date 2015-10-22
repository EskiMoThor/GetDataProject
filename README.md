# GetDataProject
Coursera Project for Getting and Cleaning Data Course

Objective for the run_analysis.R script:
- Merge the training data with the test data.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set.
- Appropriate labels the data set with descriptive variable names.
- Creates a second, independent, tidy data set with the average of each variable for each activity and each subject.

The data for the project can be downloaded from here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In the run_analysis.R script there are two functions: run_analysis() and tidy_means()

# run_analysis() 
This function does the initial cleaning and tidying up of the UCI HAR Dataset, and returns the result as a data frame.
It takes one argument, dataFolder, of a folder path. 
The dataFolder argument is the path for the extracted contents of the UCI HAR Dataset.
If the function is used without an argument it defaults to using the current working directory.
A detailed description of the output can be found in the Codebook file.

# tidy_means() 
This function creates a second tidy data set from the first.
The output is a data frame, that is also saved as CSV file, "tidy_means.csv", in the current working directory.
tidy_means takes one argument, x_Data_Set, of a data frame.
The data frame passed to tidy_means should be the output from run_analysis().

# Usage
To use the functions source the script file: source('[path to file]/run_analysis.R')
Then assign the output of run_analysis to a variable.
Then call tidymeans with that variable as the argument. Optionally assign it to another variable.

Example with the working directory set to the "UCI HAR Dataset" folder:

  source('run_analysis.R')
  
  x <- run_analysis()

  y <- tidy_means(x)
