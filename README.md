# GetDataProject
Coursera Project for Getting and Cleaning Data Course


## Objective for the run_analysis.R script:
- Merge the training data with the test data.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set.
- Appropriate labels the data set with descriptive variable names.
- Creates a second, independent, tidy data set with the average of each variable for each activity and each subject.

The data for the project can be downloaded from here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In the run_analysis.R script there are two functions: run_analysis() and tidy_means()

## run_analysis() 
This function does the initial cleaning and tidying up of the UCI HAR Dataset, and returns the result as a data frame.

It takes one argument, dataFolder, of a folder path. 

The dataFolder argument is the path for the extracted contents of the UCI HAR Dataset.

If the function is used without an argument it defaults to using the current working directory.

A detailed description of the output can be found in the CodeBook file.


## tidy_means() 
This function creates a second tidy data set from the first.

The output is a data frame, that is also saved as CSV file, "tidy_means.csv", in the current working directory.

tidy_means takes one argument, x_Data_Set, of a data frame.

The data frame passed to tidy_means should be the output from run_analysis().


## Usage
The simplest way to use the script is to set your working directory to the UCI HAR dataset folder (download link below).
Then source/run the script.


If the UCI HAR dataset folder is not the current working directory you can source the run_analysis.R file, and then manually call the functions.

Then assign the output of run_analysis to a variable.

Then call tidymeans with that variable as the argument. Optionally assign it to another variable.
Example:

    x <- run_analysis("C:\GetDataProject\UCI HAR Dataset")
    y <- tidy_means(y)


To view the contents of the saved data file, "tidy_data.txt" in R Studio:
  
    z <- read.table("tidy_means.csv", header = TRUE)
  
    view(z)
  
Alternatively the raw file contents can be viewed in any text editor.
