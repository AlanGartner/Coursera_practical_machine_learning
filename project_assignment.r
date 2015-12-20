# Clearing console
cat("\014")  

#Loading caret package
library('caret')

#Set the seed so that results are replicable
set.seed(1234)

# Going to the appropriate directory
setwd('~/Personal_files/MOOC/Machine_learning')

# Loading the datasets
dataset <- read.table("./pml-training.csv",sep=",",header= TRUE, na.strings=c("", "NA", "NULL")) 
problems <- read.table("./pml-testing.csv",sep=",",header= TRUE, na.strings=c("", "NA", "NULL")) 

# Having a look to the data
summary(dataset)
    dim(dataset)

# Let's remove the variables that have no interest for the prediction
# either through their semantic or because they have NA or null values in the problems

uselessId = c('X', 'user_name', 'raw_timestamp_part_1', 'raw_timestamp_part_2', 'cvtd_timestamp', 'new_window', 'num_window',"kurtosis_roll_belt", "kurtosis_picth_belt","kurtosis_yaw_belt","skewness_roll_belt","skewness_roll_belt.1","skewness_yaw_belt","max_roll_belt","max_picth_belt","max_yaw_belt","min_roll_belt","min_pitch_belt","min_yaw_belt","amplitude_roll_belt","amplitude_pitch_belt","amplitude_yaw_belt","var_total_accel_belt","avg_roll_belt","stddev_roll_belt","var_roll_belt","avg_pitch_belt","stddev_pitch_belt","var_pitch_belt","avg_yaw_belt","stddev_yaw_belt","var_yaw_belt","var_accel_arm","avg_roll_arm","stddev_roll_arm","var_roll_arm","avg_pitch_arm","stddev_pitch_arm","var_pitch_arm","avg_yaw_arm","stddev_yaw_arm","var_yaw_arm","kurtosis_roll_arm","kurtosis_picth_arm","kurtosis_yaw_arm","skewness_roll_arm","skewness_pitch_arm","skewness_yaw_arm","max_roll_arm","max_picth_arm","max_yaw_arm","min_roll_arm","min_pitch_arm","min_yaw_arm","amplitude_roll_arm","amplitude_pitch_arm","amplitude_yaw_arm","kurtosis_roll_dumbbell","kurtosis_picth_dumbbell","kurtosis_yaw_dumbbell","skewness_roll_dumbbell","skewness_pitch_dumbbell","skewness_yaw_dumbbell","max_roll_dumbbell","max_picth_dumbbell","max_yaw_dumbbell","min_roll_dumbbell","min_pitch_dumbbell","min_yaw_dumbbell","amplitude_roll_dumbbell","amplitude_pitch_dumbbell","amplitude_yaw_dumbbell","var_accel_dumbbell","avg_roll_dumbbell","stddev_roll_dumbbell","var_roll_dumbbell","avg_pitch_dumbbell","stddev_pitch_dumbbell","var_pitch_dumbbell","avg_yaw_dumbbell","stddev_yaw_dumbbell","var_yaw_dumbbell","kurtosis_roll_forearm","kurtosis_picth_forearm","kurtosis_yaw_forearm","skewness_roll_forearm","skewness_pitch_forearm","skewness_yaw_forearm","max_roll_forearm","max_picth_forearm","max_yaw_forearm","min_roll_forearm","min_pitch_forearm","min_yaw_forearm","amplitude_roll_forearm","amplitude_pitch_forearm","amplitude_yaw_forearm","var_accel_forearm","avg_roll_forearm","stddev_roll_forearm","var_roll_forearm","avg_pitch_forearm","stddev_pitch_forearm","var_pitch_forearm","avg_yaw_forearm","stddev_yaw_forearm")
dataset <- dataset[,-which(names(dataset) %in% uselessId)]
dim(dataset)

# a lot of columns have many NA values, let's remove them
naColCounts = apply(dataset, 2, function(x) sum(is.na(x)))
dataset=dataset[,naColCounts<11525]
dim(dataset)

# Cross validation: slicing data into training and testing set
inTrain <- createDataPartition(y=dataset$classe,p=0.7, list=FALSE)
training <- dataset[inTrain,]
testing <- dataset[-inTrain,]
dim(training)

# Identifying the columns that are the most important
classeRf <- randomForest(classe ~ ., data=training, ntree=100,keep.forest=TRUE, importance=TRUE)
varImpPlot(classeRf,)
testPredict <- predict(classeRf,newdata=testing)
summary(testing$classe != testPredict)

# now predicting on the problems
probPredict <- predict(classeRf,newdata=problems)

#rmarkdown::render("Coursera_practical_machine_learning/project_assignment.r")

