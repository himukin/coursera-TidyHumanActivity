---
title: "Getting & Cleaning Data Course Project Submission"
author: "Muthu Kesavan"
date: "26 April 2015"
output: html_document
course-id: getdata-013
---

# Introduction

* This file contains the information about the submission that was made to 
fulfill the requirement of completing Course project in the **Getting & 
Cleaning Data**
* This submission explains how the data was downloaded, cleaned and prepared for
analysis

# Source of the Data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[Data Reference](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

Here are the data for the project: 

[Data Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

# Analysis Script details

1. The above data was downloaded separately and unzipped into a directory. The same data is available with
the github.

2. All other operations required to fulfill the following steps are done in run_analysis.R that does the following. 
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

3. The script can be executed with R by calling run_analysis(). No arguments necessary, all the required
data is available with this github.
4. The script would produce **tidy.txt** which is the required outcome of the step 5 given above.

# Strategy used in the script

* Test & Training datasets are collated separately and merged later
* Feature names & activity names have been read separately and used appropriately to come up
with the descriptive variable names
* Melt & dcast functions of respectively reshape2 & plyr packages used  to calculate the average of each
variable for each activity and each subject.

# Codebook
* Code book which is the data dictionary for the outcome **tidy.txt** is described in *CodeBook.md* file.

# 