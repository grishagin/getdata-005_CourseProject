## specify variables
dirName = "UCI HAR Dataset"
zipName = "getdata-projectfiles-UCI HAR Dataset.zip"

## check if the directory exists, if not - check if the zip exists
if (!(file.exists(dirName))){
        if (file.exists(zipName)) {
                ## if directory does not exist, and zip does - unpack
                unzip(zipName)
        } else cat("Target zip file",zipName,"not found.")
}

## read all relevant files as data tables
## from corresponding test and train sections
## and merge the rows
listSubjectTest<-read.table("UCI HAR Dataset//test//subject_test.txt")
listSubjectTrain<-read.table("UCI HAR Dataset//train//subject_train.txt")
listSubjAll<-rbind(listSubjectTest,listSubjectTrain)
colnames(listSubjAll)<-"VolunteerNumber"

listActivitiesTest<-read.table("UCI HAR Dataset//test//y_test.txt")
listActivitiesTrain<-read.table("UCI HAR Dataset//train//y_train.txt")
listActivitiesAll<-rbind(listActivitiesTest,listActivitiesTrain)
colnames(listActivitiesAll)<-"Activity"

listFeaturesValuesTest<-read.table("UCI HAR Dataset//test//X_test.txt")
listFeaturesValuesTrain<-read.table("UCI HAR Dataset//train//X_train.txt")
listFeaturesValuesAll<-rbind(listFeaturesValuesTest,listFeaturesValuesTrain)

## read activities names
activitiesNames<-read.table("UCI HAR Dataset//activity_labels.txt")
activitiesNames[,2]<-as.character(activitiesNames[,2])

## replace activities numbers with corresponding names
for (i in as.integer(activitiesNames[,1])) {
        listActivitiesAll[listActivitiesAll[,1]==i,1]<-activitiesNames[i,2]
}

## read feature names and make a subset
## keeping only names containing "mean" and "std" in them
featuresNames<-read.table("UCI HAR Dataset//features.txt")
list<-c("mean\\(\\)","std")
featuresNamesProc<-subset(featuresNames,grepl(paste(list,collapse="|"),featuresNames[,2]))
## keep only mean and standard deviation values for feature
listFeaturesValuesAllProc<-listFeaturesValuesAll[,featuresNamesProc[,1]]
## rename columns in the feature values list with meaningful feature names
colnames(listFeaturesValuesAllProc)<-featuresNamesProc[,2]

## prepare combined data table with numbers of Volunteers
## and names of activities
combinedDataTable<-cbind(listSubjAll,listActivitiesAll,listFeaturesValuesAllProc)

## write the dataset into a file
write.table(combinedDataTable,"data_set_1.txt")

## create an empty data frame
activityMeanDataTable<-data.frame(x= numeric(0), y= integer(0))

## loop through every volunteer and activity
for (volNum in 1:30) {
        for (activ in activitiesNames[,2]){
                
                ## create a subset for every activity for a given volunteer
                sub<-subset(combinedDataTable, VolunteerNumber==volNum & Activity==activ)
                ## calculate the mean for every relevant column in that subset, 
                ## convert it to appropriate data frame
                sub2<-t(as.data.frame(colMeans(sub[,3:ncol(sub)])))
                ## add vounteer number and activity columns to that subset
                sub3<-cbind(sub[1,1:2],sub2)
                
                ## add each row with means to the data frame
                activityMeanDataTable<-rbind(activityMeanDataTable,sub3)
        }
}

## correct the names of the rows
row.names(activityMeanDataTable)<-1:nrow(activityMeanDataTable)

## write the second dataset into a file
write.table(activityMeanDataTable,"data_set_2.txt")
