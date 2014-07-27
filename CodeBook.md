### Transformations Performed to Clean up the Data

(1) Subject (Volunteer) labels for every observation, represented by numbers 1-30, are located in the following files:

        UCI HAR Dataset//test//subject_test.txt
        UCI HAR Dataset//train//subject_train.txt
        
+ The files contain 2947 and 7352 rows, respectively, and one column each.
+ The data tables from both files are pooled into a single data table using `rbind` function, 
and the column name is changed to "VolunteerNumber".
+ Final combined **table Volunteer** has 10299 rows and 1 column.


(2) Activity labels for every observation, represented by numbers 1-6, are located in the following files:
        
        UCI HAR Dataset//test//y_test.txt
        UCI HAR Dataset//train//y_train.txt
        
+ The files contain 2947 and 7352 rows, respectively, and one column each.
+ The data tables from both files are pooled into a single data table using `rbind` function, 
and the column name is changed to "Activity".
+ Activity labels key, uncovering which of the six activities is represented by which number,
is located in this file (table of 6 rows and 2 columns):

        UCI HAR Dataset//activity_labels.txt
        
+ Numeric activity labels are replaced by the corresponding string values according to the key.
+ Combined **table Activity** has 10299 rows and 1 column.
        
(3) The 10299 observations for all 30 subjects performing all 6 activities multiple times,
categorized into 561 variables, are located in the following files:

        UCI HAR Dataset//test//X_test.txt
        UCI HAR Dataset//train//X_train.txt
        
+ The files contain 2947 and 7352 rows, respectively (10299 total), and 561 columns each.
+ The data tables from both files are pooled into a single data table using `rbind` function.
+ Combined **table Raw Data** has 10299 rows and 561 column.

(4) The descriptions (labels) for all 561 variables are located in the following file:

        UCI HAR Dataset//features.txt
        
+ The table has 561 rows and 2 columns.
+ A subset of the labels for the variables containing only "mean()" and "std" is prepared.
This subset contains 66 rows. 
+ A subset of the **table Raw Data** for these 66 variables defined above is prepared,
and the corresponding variable labels are added to the final table as column names.
+ This **table Vars** contains 10299 rows and 66 columns.

(5) A combined dataset **table Data** is prepared using `cbind` on the **table Volunteer**, **table Activity**, and **table Vars**.
+ This combined **table Data** contains 10299 rows and 68 columns.
+ The clean dataset **table Data** is written to a file using `write.table`:
        
        data_set_1.txt

(6) A subset of the **table Data** is made by looping through all volunteer numbers (1 through 30),
and for each of these numbers looping through every activity, 
calculating the average values of each of the variables for a given volunteer and activity.
+ This **table Average Data** contains 180 rows and 68 columns.
+ Row numbers are replaced with values 1 through 180,
as they are meaningless in the absolute sense.
+ This clean dataset **table Average Data** is written to a file using `write.table`:
        
        data_set_2.txt

### Description of the Variables

(1) **Descriptive variables.**
+ **VolunteerNumber**     - volunteer number (1..30)
+ **Activity**            - activity performed by the volunteer 
        
        WALKING
        WALKING_UPSTAIRS
        WALKING_DOWNSTAIRS
        SITTING
        STANDING
        LAYING

(2) **Measurement variables.**

The variables come from the accelerometer (Acc) and gyroscope (Gyro) 3-axial signals.
The acceleration signal was then separated into body (Body) and gravity (Gravity) acceleration signals.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. 
Also the magnitude of these 3-dimensional signals were calculated. 

Finally a Fast Fourier Transform (FFT) was applied to *some* of these signals. 

Applicable 3-axial signals were recorded in the X, Y and Z directions.

Thus each name is composed of the following elements, in that order and layout:

        domainNAME-VAR-DIM

**domain** values:

        t - time domain signals.
        f - frequency domain signals obtained through FFT-processing.    

**NAME**

        BodyAcc         - body component of the accelerometer signal
        GravityAcc      - gravity component of the accelerometer signal
        BodyAccJerk     - body component of the accelerometer jerk signal
        BodyGyro        - body component of the gyroscope signal
        BodyGyroJerk    - body component of the gyroscope jerk signal
        BodyAccMag      - magnitude of the body component of the accelerometer signal
        GravityAccMag   - magnitude of the gravity component of the accelerometer signal
        BodyAccJerkMag  - magnitude of the body component of the accelerometer jerk signal
        BodyGyroMag     - magnitude of the body component of the gyroscope signal
        BodyGyroJerkMag - magnitude of the body component of the gyroscope jerk signal
        
**VAR**

        mean()  - mean value of the signal
        std()   - standard deviation of the signal

**DIM** (optional)
        
        X - signal in X direction
        Y - signal in Y direction
        Z - signal in Z direction
        
        