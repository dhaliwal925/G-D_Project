## Checks to see if directory with data exists in working directory, downloads and extracts file if missing
if (!dir.exists("UCI HAR Dataset"))
	{
		temp <- tempfile()
		download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
		unzip(temp, overwrite = TRUE)
		unlink(temp)
		rm(temp)
	}

## Read in global data
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Subset only mean and std features
features <- as.character(features$V2)
features.sub <- sort(append(grep("-mean()", fixed = TRUE,features), 
			    grep("std()",features), after = length(grep("-mean()",features))))

## Create activity label variables for data replacement
activity_labels.sub <- as.integer(activity_labels$V1)
activity_labels.assign <- as.character(activity_labels$V2)

## Create vector that will house column names
data.header <- c()
for(i in features.sub)
	{
		data.header <- append(data.header,features[i],length(data.header))		
	} 

## Read in test data and subset based on columns for mean and std
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_data <- subset(test_data, select = features.sub)

## Append column names
colnames(test_data) <- unlist(data.header)

## Read in test activity labels, rename with activity type, and name column
test_labels <- read.table("./UCI HAR Dataset/test/Y_test.txt")
for(i in activity_labels.sub)
	{
		test_labels[test_labels$V1 == i,] <- activity_labels.assign[i]
	}
colnames(test_labels) <- c("activity")

## Read in test subjects table and name column
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(test_subjects) <- c("subjects")

## Create column with data_set variable
data_set <- data.frame("Test")
data_set <- do.call("rbind", replicate(nrow(test_data), data_set, simplify = FALSE))
colnames(data_set) <- c("data_set")

## Merge test data into on table
test_out <- cbind(data_set,test_subjects,test_labels,test_data)

## Read in test data and subset based on columns for mean and std
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_data <- subset(train_data, select = features.sub)

## Append column names
colnames(train_data) <- unlist(data.header)

## Read in test activity labels and rename with activity type
train_labels <- read.table("./UCI HAR Dataset/train/Y_train.txt")
for(i in activity_labels.sub)
{
	train_labels[train_labels$V1 == i,] <- activity_labels.assign[i]
}
colnames(train_labels) <- c("activity")

## Read in test subjects table
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(train_subjects) <- c("subjects")

## Create column with data_set variable
data_set <- data.frame("Train")
data_set <- do.call("rbind", replicate(nrow(train_data), data_set, simplify = FALSE))
colnames(data_set) <- c("data_set")

## Merge test data into on table
train_out <- cbind(data_set,train_subjects,train_labels,train_data)

## Merge test and train datasets together and set factor variables
final_set <- rbind(test_out,train_out)
final_set$subjects <- as.factor(final_set$subjects)
final_set$activity <- as.factor(final_set$activity)

## Remove objects
rm(data_set, train_subjects, train_labels, train_data, activity_labels.assign,
   activity_labels.sub, features, features.sub, activity_labels, i, data.header, test_subjects,
   test_labels, test_data, test_out, train_out)

## Loop variables to find column means based on subject and activity
subjects_total <- as.integer(levels(final_set$subjects))
activities <- levels(final_set$activity)

## Create empty data.frame with column names for later use
final_mean <- data.frame(colnames(subset(final_set, select = 2:69)))

## Loop through activities and subjects to find column means
for(i in 1:length(activities))
	{
		for(j in subjects_total)
		{
			colavg <- c(j,activities[i])
			colavg <- append(colavg, colMeans(subset(final_set,
								 final_set$subjects == j & 
						       	final_set$activity == activities[i], 
						       select = 4:69)), after = length(colavg))
			final_mean <- cbind(final_mean,data.frame(colavg))
		}
	}

## Transpose output into right format
final_mean <- data.frame(t(data.frame(final_mean)), row.names = NULL)

## Extract and rename headers
data.header <- final_mean[1,]
final_mean <- final_mean[-c(1),]
colnames(final_mean) <- unlist(data.header)

## Remove objects
rm(data.header,activities,colavg,subjects_total,i,j)

## Output files
write.table(final_set, file = "./UCI HAR Dataset/final_set.txt", row.names = FALSE)
write.table(final_mean, file = "./UCI HAR Dataset/final_mean.txt", row.names = FALSE)





