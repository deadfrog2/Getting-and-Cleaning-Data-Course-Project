getwd()
list.files()
setwd("/Users/apple/coursera/Getting and Cleaning Data")
getwd()
library(dplyr)
filename <- "UCI_data"
if(!file.exists(filename)){
    dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(dataUrl,filename, method= "curl")
}
 if(!file.exists("UCI HAR Dataset")){
     unzip(filename)
 }

features <- read.table("UCI HAR Dataset/features.txt",col.names =c("n","functions") )
activities <- read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("code","activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/x_test.txt",col.names = features$functions)
head(x_test)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/x_train.txt",col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",col.names = "code")


x <- rbind(x_train,x_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)
merged_data <- cbind(subject,y,x)



tidy_data <- merged_data %>% select(subject,code, contains("mean"),contains("std"))

head(tidy_data)

tidy_data$code <- activities[tidy_data$code,2]
?gsub

names(tidy_data)[2]="activity"
names(tidy_data) <- gsub("Acc","Accelerometer",names(tidy_data))
names(tidy_data) <- gsub("Gyro","gyroscope",names(tidy_data))
names(tidy_data) <- gsub("BodyBody","Body",names(tidy_data))
names(tidy_data) <- gsub("Mag","Magnitude",names(tidy_data))
names(tidy_data) <- gsub("^t","Time",names(tidy_data))
names(tidy_data) <- gsub("^f","Frequency",names(tidy_data))
names(tidy_data) <- gsub("tBody","Timebody",names(tidy_data))
names(tidy_data) <- gsub("-mean()","Mean",names(tidy_data))
names(tidy_data) <- gsub("-std()","STD",names(tidy_data))
names(tidy_data) <- gsub("-freq()","Frequency", names(tidy_data))
names(tidy_data) <- gsub("angle","Angle",names(tidy_data))
names(tidy_data) <- gsub("gravity","Gravity",names(tidy_data))

Second_tidy_data <- tidy_data %>% group_by(subject,activity) %>%
    summarize_all(mean)
head(Second_tidy_data)
Second_tidy_data
sessionInfo()
