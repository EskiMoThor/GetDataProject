## run_analysis.R
## Coursera getdata-033 Course Project

## Merge the training data with the test data.
## Extract only the measurements on the mean and standard deviation for each measurement.
## Uses descriptive activity names to name the activities in the data set.
## Appropriate labels the data set with descriptive variable names.
## Creates a second, independent, tidy data set with the average of each
## variable for each activity and each subject.

## Create the first tidy data set.
## The dataFolder argument is the path for the UCI HAR Dataset.
## The default path is the current working directory.
run_analysis <- function(dataFolder=getwd()){
  ## Variables for file paths and files names
  x_trainFile <- file.path(dataFolder, "train/X_train.txt")
  x_testFile <- file.path(dataFolder, "test/X_test.txt")
  x_featuresFile <- file.path(dataFolder, "features.txt")
  x_activity_labels_file <- file.path(dataFolder, "activity_labels.txt")
  y_train_file <- file.path(dataFolder, "train/y_train.txt")
  y_test_file <- file.path(dataFolder, "test/y_test.txt")
  s_train_file <- file.path(dataFolder, "train/subject_train.txt")
  s_test_file <- file.path(dataFolder, "test/subject_test.txt")
  
  ## Read the training data into data frames.
  x_train <- read.table(x_trainFile)
  y_train <- read.table(y_train_file)
  s_train <- read.table(s_train_file)
  
  ## Read the test data into data frames.
  x_test <- read.table(x_testFile)
  y_test <- read.table(y_test_file)
  s_test <- read.table(s_test_file)
  
  ## Read the activity labels and feature names data
  x_activity_labels <- read.table(x_activity_labels_file)
  x_features <- read.table(x_featuresFile)
  
  ## Assign the names to the columns of the test and training data frames.
  names(x_train) <- x_features$V2
  names(x_test) <- x_features$V2
  
  ## Merge the data sets.
  x_total <- rbind(x_train, x_test)
  
  ## Keep only the columns with mean or standard deviations, remove all others.
  x_std_columns <- grep("std\\(", names(x_total), ignore.case = TRUE)
  x_mean_columns <- grep("mean\\(", names(x_total), ignore.case = TRUE)
  x_keep_columns <- c(x_mean_columns, x_std_columns)
  x_total <- x_total[, x_keep_columns]
  
  ## Clean up the variable names a bit by removing special characters
  names(x_total) <- gsub("[[:punct:]]", "", names(x_total))
  
  ## Append the activity data as descriptive labels
  y_total <- rbind(y_train, y_test)
  y_labelled <- as.factor(y_total$V1)
  levels(y_labelled) <- x_activity_labels$V2
  x_total$Activity <- y_labelled
  
  ## Append subject data and return the data set.
  s_total <- rbind(s_train, s_test)
  x_total$Subject <- as.factor(s_total$V1)
  x_total

}

## Creates a second tidy data set from an existing data set with the
## average of each variable.
## Use the data set returned by the run_analysis function as the parameter.
tidy_means <- function(x_Data_Set){
  library(reshape2)
  library(dplyr)
  
  ## Create long data frame.
  data_melt <- melt(x_Data_Set, id.vars = c("Subject", "Activity"))
  
  ## Create wide data frame with the mean of each value for each combination of subject and activity. 
  data_cast <- dcast(data_melt, Subject + Activity ~ variable, mean)
  
  ## Arrange the data by subject and activity.
  data_cast <- arrange(data_cast, Subject, Activity)
  
  ## Save the data set to a file.
  write.table(data_cast, file = "tidy_data.txt", row.names = FALSE)
  
  ## Return the tidy data.
  data_cast
}

if(dir.exists(file.path("test")) && dir.exists( file.path("train"))){
  message("Starting run_analysis...")
  r_a <- run_analysis()
  message("Starting tidy_means...")
  tidy_data <- tidy_means(r_a)
  message("Analysis completed.")
  message("Output of run_analysis assigned to r_a")
  message("Output of tidy_means assigned to tidy_data")
  message("Output of tidy_means saved to file: tidy_data.txt")
}
