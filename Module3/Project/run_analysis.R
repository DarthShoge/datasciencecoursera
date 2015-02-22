setwd('D:\\Documents\\Coursera\\DataScience\\Module3\\Project')
library(reshape2)

quickmerge <- function(lhs,rhs){
  lht <- read.table(lhs,header = FALSE)
  rht <- read.table(lhs,header = FALSE)
  rbind(lht,rht)
}

##step 1: Merges the training and the test sets to create one data set.

xmerge <- quickmerge('./train/X_train.txt'
                     ,'./test/X_test.txt')

ymerge <- quickmerge('./train/y_train.txt'
                ,'./test/y_test.txt')

subjectmerge <- quickmerge('./train/subject_train.txt',
                           './test/subject_test.txt')

##step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table('./features.txt')

featuresOfInterest <- grep("mean|Mean|std",features[,2])

##step 3:Uses descriptive activity names to name the activities in the data set
stdmeans <- xmerge[,featuresOfInterest]

activities <- read.table('./activity_labels.txt')

ymerge[,1] <- activities[ymerge[,1],2]
names(ymerge) <- "activity"

##step4: Uses descriptive activity names to name the activities in the data set
names(subjectmerge) <- "subject"
cleannames <- gsub('[^0-9A-Za-z]','',features[,2])
names(stdmeans) <- cleannames[featuresOfInterest]


##step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

mergeall <- cbind(stdmeans,ymerge,subjectmerge)
ids <- c("activity","subject")
measures <- setdiff(colnames(mergeall), ids)
melted <- melt(mergeall,id=ids,measure.vars = measures)
cleansummary <- dcast(melted, activity + subject ~ variable, mean) 