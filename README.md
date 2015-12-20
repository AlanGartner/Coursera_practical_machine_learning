# Coursera_practical_machine_learning
This file contains my answers to the coursera practical machine learning MOOC assignment.

##Answers
###How I built my model
First I had a look to the data to get a feeling of its format. I saw that the "problems" do not involve time series, but just snapshots. I also saw that many variables involved NA values, and that there were too many predictors. My first action was therefore to simplify the dataset by pruning some predictors. To do this I used following ideas:

1. the problems have null / na values for some columns: those can be removed from the training as well -> 54 variables left
2. some columns are full of NA, they can be removed -> 53 variables left
3. Only 20 variables really impact the predictions.

After this, I was left with a much simpler problem: only 20 predictors out of 160.

![alt tag](https://raw.github.com/AlanGartner/Coursera_practical_machine_learning/gh-pages/selected_vars.png)


###Explanation of my choices

As the run time was reasonable with randomForest function, I decided to keep all 53 predictors.

I used from start the random forest approach because there was no clear linear relationship among the predictors and the random forest algorithm is one of the most efficient in prediction contests.

To verify the efficiency of this algorithm I calculated the out of sample error rate on the training set (as random trees algorithm resamples) and on a testing set (just to be sure). As the error rate was below 1% I sticked to this algorithm.

    > probPredict
     1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 
     B  A  B  A  A  E  D  B  A  A  B  C  B  A  E  E  A  B  B  B 
                                                                                                                 
###Cross validation usage
I split the dataset so that 60% of the users go into training set and 40% into the testing set. This is not totally required, because I have used a random forest approach, but I wanted to double check the out of sample error.

###Expected out of sample error
Keeping 53 variables, the prediction error rate is :

    Call:
     randomForest(formula = classe ~ ., data = training, ntree = 100,      keep.forest = FALSE, importance = TRUE) 
               Type of random forest: classification
                     Number of trees: 100
    No. of variables tried at each split: 7

    **OOB estimate of  error rate: 0.66%**

    Confusion matrix:
         A    B    C    D    E class.error
    A 3900    4    1    0    1 0.001536098
    B   17 2632    9    0    0 0.009781791
    C    0   18 2373    5    0 0.009599332
    D    1    0   23 2226    2 0.011545293
    E    0    0    3    6 2516 0.003564356

To be safe, I double check on my testing set.

    > testPredict <- predict(classeRf,newdata=testing)
    > summary(testing$classe != testPredict)
       Mode   FALSE    TRUE    NA's 
    logical    5861      24       0 
Those 24 errors correspond to a 0.04% error rate. This confirms that I can expect an out of sample error below 1%


###Project files (R script)

[Link to the github repository containing my .Rmd or .md file and my compiled HTML file performing the analysis.](https://github.com/AlanGartner/Coursera_practical_machine_learning)    
