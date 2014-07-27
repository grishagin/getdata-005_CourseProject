### Contents of the Repo

* ReadMe.md             - this file
* run_analysis.R        - R script
* CodeBook.md           - description of the data processing and variables
* data_set_1.txt        - clean dataset 1 prepared by the R script
* data_set_2.txt        - clean dataset 2 prepared by the R script

### General Description

The R script is designed to analyse one particular set of raw data collected 
from the accelerometers and gyroscope from the Samsung Galaxy S smartphone.

The script prepares two clean datasets and writes them into two text files.
The files are enclosed in this repo.

Codebook.md contains the description of all transformations performed to clean up the raw data,
as well as the detailed description of all the vatiables.

### Script Elucidation

*For a more detailed description of the data processing, see CodeBook.md.*

(1) Unzips the zip archive into the currect working directory.

(2) Merges subject (Volunteer) labels from following files:

        UCI HAR Dataset//test//subject_test.txt
        UCI HAR Dataset//train//subject_train.txt

(3) Merges activity labels from following files:
        
        UCI HAR Dataset//test//y_test.txt
        UCI HAR Dataset//train//y_train.txt
        
+ Changes the column name to "Activity".
+ Replaces numeric activity labels by the corresponding string values according to the key:

        UCI HAR Dataset//activity_labels.txt
        
(4) Merges the observations for all subjects performing all activities,
categorized into 561 variables, located in the following files:

        UCI HAR Dataset//test//X_test.txt
        UCI HAR Dataset//train//X_train.txt

(5) Makes a subset of the labels that contain only "mean()" and "std"
from the 561 labels of the variables located in the following file:

        UCI HAR Dataset//features.txt
        
(6) Makes a subset of the measurement variables corresponding to the subset of their labels.
Adds the labels to this subset of measurement variables as column names.

(7) Makes a combined clean dataset by merging subject (Volunteer) labels, activity labels,
and subset of observations into one data table and writing it to a file:
        
        data_set_1.txt

(8) Loops through all volunteer numbers (1..30),
and for each of these numbers loops through every activity, 
calculating the average values of each of the variables for a given volunteer and activity.
Records these averages into another data table.
Replaces row numbers with values from 1 to 180, and records the final clean dataset into a file:
        
        data_set_2.txt


### Instructions

(1) Download the zip archive:   
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
(2) Place the zip file into your R working directory. 
(3) Download the run_analysis.R from this repo.
(4) Launch the run_analysis.R.