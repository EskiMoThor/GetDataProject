# CodeBook

This document describes the code and data used in run_analysis.R


## Objective
The objective is to simplify and clean the UCI HAR data set to produce a tidy data set.

This is done in two steps:

- run_analysis() reads the data and processes the content to produce a single data frame with appropriately named columns.

- tidy_means() processes the output from run_analysis() to produce a tidy data set with the average for each activity and each subject.

## Usage
The simplest way to use the script is to set your working directory to the UCI HAR dataset folder (download link below).
Then source/run the script.


If the UCI HAR dataset folder is not the current working directory you can source the run_analysis.R file, and then manually call the functions.

Then assign the output of run_analysis to a variable.

Then call tidymeans with that variable as the argument. Optionally assign it to another variable.
Example:

    x <- run_analysis("C:\GetDataProject\UCI HAR Dataset")
    y <- tidy_means(y)


## Input for run_analysis()
This function takes one argument, a string with the path to the folder containing the UCI HAR data set.

If no argument is provided it defaults to the current working directory.

The data can be downloaded here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#### The files used are:
- Training set: "/train/X_train.txt"
- Test set: "/test/X_test.txt"
- Features list: "features.txt"
- Activity labels: "activity_labels.txt"
- Training labels: "train/y_train.txt"
- Test labels: "test/y_test.txt"
- Training subjects: "train/subject_train.txt"
- Test subjects: "test/subject_test.txt"

Further details about the input data are available in the contents of the zip file.


## Output of run_analysis()
The output is a dataframe consisting of 10299 observations of 68 variables.

All observations from the original data set are preserved, but only the variables containing mean or standard deviation values are output.


#### run_analysis() Output Variables
- Subject: An identifier of the subject who carried out the experiment (1-30).
- Activity: Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone
- The rest are means and standard deviations of preprocessed sensor data:
  * "f" or "t" indicates the domain of the data, "t" variables are time based values, "f" variables are frequency based values.
  * "body" or "gravitiy" seperates accelaration signals.
  * "Acc" or "Gyro" denotes the source of the signal, accelerometer or gyroscope.
  * "Jerk" indicates that the variable is the computed Jerk signal.
  * "Mag" indicates that the variable is a calculated magnitude.
  * "mean" indicates that the variable is a computed mean.
  * "std" indicates that the variable is a computed standard deviation.
  * "X", "Y", "Z" indicates the direction of the signal.


## Input for tidy_means()
The input is the data frame returned by run_analysis()


## Output of tidy_means()
The output is a wide data frame sorted by Subject, then Activity.

The rows contain the means of the variables for each combination of Subject and Activity.


#### tidy_means Output Variables
The variables are the same as in the output of run_analysis().


## Code description
At the end of the script it checks if "test" and "train" folders exist in the current working directory.

If they do, the script automatically runs the analysis: run_analyis() is called and assigned to r_a, then tidy_means(r_a) is called to produce the final output. .


#### run_analysis() Code Description
First the training data is read into data frames using the read.table() function.

Then the test date is read in the same manner.

We then read the labels for the activity data and the names of the features.

Next we assign the feature names to the column names for the training and test data sets.

The training and test data are just two parts of the same experiment, so we can merge them together by adding the rows of one to the other.
So, we use rbind() to merge the two data frames into a data frame: x_total.

Only the columns with mean or standard devitation data are needed, so we select only those.
First we create a vector with the column names containing "std("  (standard deviations), then one for "mean(" (means).
We then subset the x_total data frame by selecting all rows and only the columns in the two vectors created in the previous step.

Many columns names are containing a lot of special characters, which can make it difficult to work with.
So we remove all special characters with the gsub() function.

Now we can add the activity data.
First we merge the training and test data frames.
The type of the activity data is integer, so we transform it into factors and rename the levels using the activity labels.
We then append this as a new column named Activity.

Next we add the subject data.
Again the training data can be merged with the test data with the rbind() function.
The subject data is then appended as a new column named Subject.

The result, x_total is then returned.

#### tidy_means() Code Description
First, load the libraries needed, "reshape2" and "dplyr".

We use melt() to transform the data frame into a long data frame, with Subject and Activity retained as identifiers of groups.

Then we use dcast() to turn each unique variable into a column, and for each unique combination of Subject and Activity aggregate the variable values into a single value by calculating the mean.

The data is then sorted by Subject and then by Activity.

Next the final result is saved as "tidy_means.csv".

Finally the result is returned.
