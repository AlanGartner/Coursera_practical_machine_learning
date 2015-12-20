# Coursera_practical_machine_learning
This file contains my answers to the coursera practical machine learning MOOC assignment.

##Answers
###How I built my model
First I had a look to the data to get a feeling of its format. I saw that the "problems" do not involve time series, but just snapshots. I also saw that many variables involved NA values, and that there were too many predictors. My first action was therefore to simplify the dataset by pruning some predictors. To do this I used to ideas:
1. the problems have null / na values for some columns: those can be removed from the training as well
2. some columns are full of NA, they can be removed
3. remaining columns can be sorted by importance to keep the most relevant only.

After this, I was left with a much simpler problem: only 20 predictors out of 160.

![alt tag](https://raw.github.com/AlanGartner/Coursera_practical_machine_learning/gh-pages/variable_importance.png)

I also read the paper to understand the experimental setting and its link to the collected data. I noted that the authors had selected 17 features:
> "in the belt, the mean and variance of the roll,
maximum, range and variance of the accelerometer vector,
variance of the gyro and variance of the magnetometer. 

> In the  arm,  the  variance  of  the  accelerometer  vector  and  the
maximum and minimum of the magnetometer.

> In the dumbbell, the maximum of
the  acceleration,  variance  of  the  gyro  and  maximum  and
minimum of the magnetometer, while in the glove, the sum
of  the  pitch  and  the  maximum  and  minimum  of  the  gyro"
I used this info to start my model with a subset of the variables.


###Cross validation usage
I split the dataset so that 60% of the users go into training set and 40% into the testing set. This is not totally required, because I am going to use a random forest approach, but I want to double check the out of sample error.

###Expected out of sample error

###Explanation of my choices

###Project files

[Link to the github repository containing my .Rmd or .md file and my compiled HTML file performing the analysis.](https://github.com/AlanGartner/Coursera_practical_machine_learning)

##R code
    

    
    
#Answers to the problems
## Instructions
 Please apply the machine learning algorithm you built to each of the 20 test cases in the testing data set. For more information and instructions on how to build your model see the prediction assignment writeup. For each test case you should submit a text file with a single capital letter (A, B, C, D, or E) corresponding to your prediction for the corresponding problem in the test data set. You get 1 point for each correct answer. You may submit up to 2 times for each problem. I know it is a lot of files to submit. It may be helpful to use the following function to create the files. If you have a character vector with your 20 predictions in order for the 20 problems. So something like (note these are not the right answers!):

    answers = rep("A", 20)

then you can load this function by copying and pasting it into R:

 
    pml_write_files = function(x){
      n = length(x)
      for(i in 1:n){
        filename = paste0("problem_id_",i,".txt")
        write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
      }
    }

then create a folder where you want the files to be written. Set that to be your working directory and run:

 
    pml_write_files(answers)

and it will create one file for each submission. Note: if you use this script, please make sure the files that get written out have one character each with your prediction for the corresponding problem ID. I have noticed the script produces strange results if the answers variable is not a character vector. 

##Appendix
###Instructions

The goal of your project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set. You may use any of the other variables to predict with. You should create a report describing how you built your model, how you used cross validation, what you think the expected out of sample error is, and why you made the choices you did. You will also use your prediction model to predict 20 different test cases. 

1. Your submission should consist of a link to a Github repo with your R markdown and compiled HTML file describing your analysis. Please constrain the text of the writeup to < 2000 words and the number of figures to be less than 5. It will make it easier for the graders if you submit a repo with a gh-pages branch so the HTML page can be viewed online (and you always want to make it easy on graders :-).
2. You should also apply your machine learning algorithm to the 20 test cases available in the test data above. Please submit your predictions in appropriate format to the programming assignment for automated grading. See the programming assignment for additional 

###Dataset preview

####Files
    > ls *.csv
    
    -rw-r--r--@ 1 gbertran  staff    15K Dec 14 20:53 pml-testing.csv
    -rw-r--r--@ 1 gbertran  staff    12M Dec 14 20:53 pml-training.csv


####List of headers
    > head -1 pml-training.csv 
    "","user_name","raw_timestamp_part_1","raw_timestamp_part_2","cvtd_timestamp","new_window","num_window","roll_belt","pitch_belt","yaw_belt","total_accel_belt","kurtosis_roll_belt","kurtosis_picth_belt","kurtosis_yaw_belt","skewness_roll_belt","skewness_roll_belt.1","skewness_yaw_belt","max_roll_belt","max_picth_belt","max_yaw_belt","min_roll_belt","min_pitch_belt","min_yaw_belt","amplitude_roll_belt","amplitude_pitch_belt","amplitude_yaw_belt","var_total_accel_belt","avg_roll_belt","stddev_roll_belt","var_roll_belt","avg_pitch_belt","stddev_pitch_belt","var_pitch_belt","avg_yaw_belt","stddev_yaw_belt","var_yaw_belt","gyros_belt_x","gyros_belt_y","gyros_belt_z","accel_belt_x","accel_belt_y","accel_belt_z","magnet_belt_x","magnet_belt_y","magnet_belt_z","roll_arm","pitch_arm","yaw_arm","total_accel_arm","var_accel_arm","avg_roll_arm","stddev_roll_arm","var_roll_arm","avg_pitch_arm","stddev_pitch_arm","var_pitch_arm","avg_yaw_arm","stddev_yaw_arm","var_yaw_arm","gyros_arm_x","gyros_arm_y","gyros_arm_z","accel_arm_x","accel_arm_y","accel_arm_z","magnet_arm_x","magnet_arm_y","magnet_arm_z","kurtosis_roll_arm","kurtosis_picth_arm","kurtosis_yaw_arm","skewness_roll_arm","skewness_pitch_arm","skewness_yaw_arm","max_roll_arm","max_picth_arm","max_yaw_arm","min_roll_arm","min_pitch_arm","min_yaw_arm","amplitude_roll_arm","amplitude_pitch_arm","amplitude_yaw_arm","roll_dumbbell","pitch_dumbbell","yaw_dumbbell","kurtosis_roll_dumbbell","kurtosis_picth_dumbbell","kurtosis_yaw_dumbbell","skewness_roll_dumbbell","skewness_pitch_dumbbell","skewness_yaw_dumbbell","max_roll_dumbbell","max_picth_dumbbell","max_yaw_dumbbell","min_roll_dumbbell","min_pitch_dumbbell","min_yaw_dumbbell","amplitude_roll_dumbbell","amplitude_pitch_dumbbell","amplitude_yaw_dumbbell","total_accel_dumbbell","var_accel_dumbbell","avg_roll_dumbbell","stddev_roll_dumbbell","var_roll_dumbbell","avg_pitch_dumbbell","stddev_pitch_dumbbell","var_pitch_dumbbell","avg_yaw_dumbbell","stddev_yaw_dumbbell","var_yaw_dumbbell","gyros_dumbbell_x","gyros_dumbbell_y","gyros_dumbbell_z","accel_dumbbell_x","accel_dumbbell_y","accel_dumbbell_z","magnet_dumbbell_x","magnet_dumbbell_y","magnet_dumbbell_z","roll_forearm","pitch_forearm","yaw_forearm","kurtosis_roll_forearm","kurtosis_picth_forearm","kurtosis_yaw_forearm","skewness_roll_forearm","skewness_pitch_forearm","skewness_yaw_forearm","max_roll_forearm","max_picth_forearm","max_yaw_forearm","min_roll_forearm","min_pitch_forearm","min_yaw_forearm","amplitude_roll_forearm","amplitude_pitch_forearm","amplitude_yaw_forearm","total_accel_forearm","var_accel_forearm","avg_roll_forearm","stddev_roll_forearm","var_roll_forearm","avg_pitch_forearm","stddev_pitch_forearm","var_pitch_forearm","avg_yaw_forearm","stddev_yaw_forearm","var_yaw_forearm","gyros_forearm_x","gyros_forearm_y","gyros_forearm_z","accel_forearm_x","accel_forearm_y","accel_forearm_z","magnet_forearm_x","magnet_forearm_y","magnet_forearm_z","classe"