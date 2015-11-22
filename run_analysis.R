RunAnalysis <- function() {
  ## load dplyr package
  library("dplyr", lib.loc="C:/Program Files/R/R-3.2.2/library")
  
  ## put test and train files in working directory and read in via read.table
  ## test data set subjects
  subTest <- read.table("subject_test.txt")
  colnames(subTest) <- c("subject")
  
  ## test data set activities
  yTest <- read.table("y_test.txt")
  colnames(yTest) <- c("ActivityCode")
  
  ##test data set observations
  XTest <- read.table("X_test.txt")
  
  ## training data set subjects
  subTrain <- read.table("subject_train.txt")
  colnames(subTrain) <- c("subject")
  
  ## training data set activities
  yTrain <- read.table("y_train.txt")
  colnames(yTrain) <- c("ActivityCode")
  
  ## training data set observations
  XTrain <- read.table("X_train.txt") 
  
  ## read in variable names in features.txt--do not convert to factors; assign as col names
  Features <- read.delim("features.txt", header = FALSE, sep = " ", colClasses = "character")
  
  ## read in activity labels
  ActLbl <- read.table("activity_labels.txt")
  colnames(ActLbl) <- c("ActivityCode", "Activity")
  
  ## assign variable names to test and training observations
  DatVarNames <- Features$V2
  colnames(XTest) <- DatVarNames
  colnames(XTrain) <- DatVarNames
  
  ## combine the subject, activity and observation data frames for the test data set
  AllTestDat <- cbind(subTest,yTest,XTest)
  colnames(AllTestDat)[1] <- c("Subject")
  
  ## combine the subject, activity and observation data frames for the training data set 
  AllTrainDat <- cbind(subTrain,yTrain,XTrain)
  colnames(AllTrainDat)[1] <- c("Subject")
  
  ## combine the test and training data frames into one data frame
  AllDat <- rbind(AllTestDat, AllTrainDat)
  
  ## take a subset of just the observation variables with both a mean and a standard deviation
  DatVarNames <- colnames(AllDat)
  DatVarNames <- DatVarNames[setdiff(grep("subject|activity|-mean()|-std()", DatVarNames, ignore.case = TRUE),
                                     grep("-meanfreq()", DatVarNames, ignore.case = TRUE))]
  MeanStdDat <- AllDat[, DatVarNames]
  
  ## add the activity labels to the file by using merge
  MeanStdDat <- merge(MeanStdDat, ActLbl, by.x = "ActivityCode", by.y ="ActivityCode", all.x = TRUE )
  
  ## change the order so that the Subject, ActivityCode, Activity columns are at the extreme left
  MeanStdDat <- select(MeanStdDat, Subject, ActivityCode, Activity, everything())
  
  ## sort by Subject, ActivityCode, Activity then group by Subject, ActivityCode, Activity
  MeanStdDat <- arrange(MeanStdDat,Subject, ActivityCode, Activity)
  myGrp <- group_by(MeanStdDat, Subject, ActivityCode, Activity)
  
  ## summarize each of the variables by Subject, ActivityCode, Activity
  ## I grouped by ActivityCode for expediency
  mySum <- summarise_each(myGrp, funs(mean))
  
  ## change the variable names and output the file
  SumName <- DatVarNames[c(-1,-2)]
  NewName <- paste0("Average(", SumName, ")")
  colnames(mySum) <- c("Subject","ActivityCode","Activity", NewName)
  write.table(mySum, "PhoneDataSummary.txt", row.names = FALSE)
  mySum <<- mySum
  
}