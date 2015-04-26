##This function does the following
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
run_analysis <- function() {
    
    ##Step  1. Merges the training and the test sets to create one data set.
    ## reading features
    features.df <- read.table("features.txt")
    
    ## reading activity labels and store in the parent environment
    activities.df <<- read.table("activity_labels.txt")
    activities.df[,1] <<- as.numeric(activities.df[,1]) 
    
    ## reading test dataset
    test.x.df <- read.table("test/X_test.txt")
    test.y.df <- read.table("test/y_test.txt")
    test.subject.df <- read.table("test/subject_test.txt")
    
    ## reading train dataset
    train.x.df <- read.table("train/X_train.txt")
    train.y.df <- read.table("train/y_train.txt")
    train.subject.df <- read.table("train/subject_train.txt")
    
    ## adding column names to x tables
    colnames(train.x.df) <- features.df[,2]
    colnames(test.x.df) <- features.df[,2]
    
    ## creating full test data set 
    test.full.df <- test.subject.df
    test.full.df$y <- test.y.df[,1]
    colnames(test.full.df) <- c("subject","y")
    test.full.df <- cbind(test.full.df,test.x.df)
    
    ## creating full training data set 
    train.full.df <- train.subject.df
    train.full.df$y <- train.y.df[,1]
    colnames(train.full.df) <- c("subject","y")
    train.full.df <- cbind(train.full.df,train.x.df)  
    
    test.length <- nrow(test.subject.df)
    train.length <- nrow(train.subject.df)
    full.length <- test.length + train.length
    
    ## Add id column in train data set
    train.full.df <- cbind(1:train.length,train.full.df)
    ## Add id coumn in test data set
    test.full.df <- cbind((train.length+1):full.length,test.full.df)
    
    ## 4. Appropriately labels the data set with descriptive variable names.     
    
    ## all colunm names
    column.names <- c("id","subject","activity",as.character(features.df[,2]))
    
    ## assign column names to the both sets
    colnames(test.full.df) <- column.names
    colnames(train.full.df) <- column.names
    
    
    ##Step  1. Merges the training and the test sets to create one data set.
    
    ## merge training & test datasets into one full set
    full.data.df <-rbind(train.full.df,test.full.df)
    
    #Step 2:Extracts only the measurements on the mean and standard deviation for
    ##       each measurement. 
    
    feature.names <- features.df[,2]
    mean_indices <- grep("-mean\\(\\)",feature.names,ignore.case = TRUE)
    std_indices <- grep("-std\\(\\)",feature.names,ignore.case = TRUE)
    
    all_indices <- c(mean_indices,std_indices)
    #correct for the initial 3 (id, subject, activity) columns
    all_indices <- all_indices +3
    
    full.data.mean.and.std.df <- full.data.df[c(1:3,all_indices)]
    ## 3. Uses descriptive activity names to name the activities in the data set
    full.data.mean.and.std.df$ActivityName <- sapply(
            full.data.mean.and.std.df$activity,
            function(x) activities.df[activities.df$V1 == x,][,2])    
    
    ## 5. From the data set in step 4, creates a second, independent tidy data set 
    ##    with the average of each variable for each activity and each subject.
    
    library("reshape2")
    
    #first melt the data so that measurements would come under variable column
    # and ids are 'activity', 'ActivityName' and subject
    melted.df <- melt(full.data.mean.and.std.df,
                      id=c("activity","ActivityName","subject"),
                      colnames(full.data.mean.and.std.df)[
                          4:(ncol(full.data.mean.and.std.df)-1)])
    
    library("plyr")
    # now dcast to find the mean(average) of each variable for each activity &
    # subject
    mean.df <- dcast(melted.df,ActivityName+subject ~ variable, mean)
    write.table(mean.df,"tidy.txt",row.name=FALSE)
    invisible(mean.df)
}

get_activity_name <- function(activity) {
   activities.df[activities.df$V1 == activty,][,2]    
}
