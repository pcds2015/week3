# Merge training and test set in X
activities <- read.csv("activity_labels.txt", sep=" ", header = F) # Labels for activities

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
y_labeled <- merge(y_test, activities, by.x="V1", by.y="V1") # Merge with labels to get activity labels
subject_test <- read.table("test/subject_test.txt")
data1_test <- cbind(X_test, y_labeled$V2, subject_test)

X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
y_labeled <- merge(y_train, activities, by.x="V1", by.y="V1") # Merge with labels to get activity labels
subject_train <- read.table("train/subject_train.txt")
data1_train <- cbind(X_train, y_labeled$V2, subject_train)

# - use variable names
data1 <- rbind(data1_test, data1_train)
variables <- as.character(read.csv("features.txt", header=F, sep = " ")$V2)
colnames(data1) <- c(variables, "activity", "subject")

# Extract the measurements on the mean and standard deviation for each measurement
# - only do this for a subset to complete exercise
data2 <- data1[, c("tBodyAcc-mean()-X", "tBodyAcc-std()-X", "activity", "subject")]

# Group by subject and activity
library(dplyr)
data2 %>% group_by(subject,activity) %>% summarize(`tBodyAcc-mean()-X` = mean(`tBodyAcc-mean()-X`), `tBodyAcc-std()-X`=mean(`tBodyAcc-mean()-X`)) %>% data3
