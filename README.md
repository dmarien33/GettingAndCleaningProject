#RunAnalysis function in run_analysis.R file
## load dplyr package
## Download files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip in working directory
## put test and train files in working directory and read in via read.table
  * test data set subjects
  * test data set activities
  * test data set observations
  * training data set subjects
  * training data set activities
  * training data set observations

## read in variable names in features.txt--do not convert to factors (header = FALSE, sep = " ", colClasses = "character") 
  
## read in activity labels with read.table
* make column names "ActivityCode", "Activity"

## assign variable names to test and training observations
* use variable names in features.txt

## combine the subject, activity and observation data frames for the test data set using cbind

## combine the subject, activity and observation data frames for the training data set using cbind
  
## combine the test and training data frames into one data frame using rbind
  
## take a subset of just the observation variables with both a mean and a standard deviation
  
## add the activity labels to the file by using merge
* I did not use any dplyr functions until I had brought together all the other data to avoid reordering subsets of the data
  
## change the order so that the Subject, ActivityCode, Activity columns are at the extreme left

## sort by Subject, ActivityCode, Activity then group by Subject, ActivityCode, Activity
  
## summarize each of the variables (calculate the mean) by Subject, ActivityCode, Activity
* I grouped by ActivityCode because I thought that it would make things neater
  
## change the variable names and output the file
* I changed the variable names by adding Average() to each variable where the mean was calculated (example:  Average(tBodyAcc-mean()-X))
* the original variable names were included for easy trace back
* data frame was output with this line of code:  write.table(mySum, "PhoneDataSummary.txt", row.names = FALSE)

## if you want to read the tidy data set back in, do this:
* read in the file "MySumColumnClasses.csv" which contains the column classes
* code to read in data: testRead <- read.table("PhoneDataSummary.txt", header = TRUE, sep = " ", colClasses = ColVect) 
* ColVect is the vector of column classes created by reading in "MySumColumnClasses.csv"


  
}
  