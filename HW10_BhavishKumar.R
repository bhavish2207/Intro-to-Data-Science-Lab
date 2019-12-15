# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 10
# Date due: 11th NOVEMBER 2019
#
# Attribution statement: (choose the statements that are true)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear all user objects from the environment!!!

# Set working directory 
# Change to the folder containing your homework data files
setwd("C:\\Users\\LENOVO\\Desktop\\SYR ADS\\Sem 1\\IST 687 Intro to Data Science\\Prep Exercise & Homework")

### PREP EXERCISE 10

## 1.	Getting Ready: Loading and Verifying the Diamonds Dataset.

## a.	This week's "diamonds" dataset comes from the ggplot2 package while the SVM function are located within a package called kernlab. 
##    Therefore, you will need to install and library ggplot2 and kernlab.

library(ggplot2)
install.packages("kernlab")
library(kernlab)

## b.	Assign the "diamonds" dataset to a dataframe and view the dataset. You will notice that there are five cuts of diamonds: 
##    Fair, Good, Very Good, Premium and Ideal.

diamonds_df <-diamonds

## c.	View the dataframe and place a screenshot below. It is not important to fit the entire dataset in the screenshot, 
##    just enough to verify that you have completed the above steps.

View(diamonds_df)

##2.	Cleaning the data.
## a.	To simplify our classification task, we will focus only on Premium and Ideal cuts of diamonds. 
##    Below, there are two different ways to create the subset of the dataframe that fits the two "cut" categories. 
##    Create a new dataframe, called 'goodDiamonds' that only has the "Primium" and "Ideal" cut of diamons.

goodDiamonds <- diamonds_df[(diamonds_df$cut== "Premium" | diamonds_df$cut == "Ideal"),]

table(goodDiamonds$cut)

## b.	The clarity and color variables in the dataframe are "ordered factors." This means that for analytical purposes such as this, 
##    you can convert the factor level directly into a number and it will make sense. Convert the clarity and color variables into numbers.
##    (Hint: use the as.numeric() command to accomplish this)

goodDiamonds$color <- as.numeric(goodDiamonds$color)
goodDiamonds$clarity <- as.numeric(goodDiamonds$clarity)


## c.	The cut attribute now has two level (just premium and ideal), but the dataframe still has the initial five factors. 
##    You can fix this by using the following code:
  
goodDiamonds$cut<-as.factor(as.character(goodDiamonds$cut))

## d.	View the adjusted dataframe and place a screenshot below.

View(goodDiamonds)
summary(goodDiamonds)
str(goodDiamonds)
table(goodDiamonds$cut)

## e.	In a block comment, describe the meaning of each variable within the dataframe.

# The diamonds dataframe contains 53940 rows and 10 columns (variables). The 10 variables are:
#  -	Price: price in US dollars
#  -	Carat: weight of the diamond
#  -	Cut: quality of the cut (Fair, Good, Very Good, Premium, Ideal)
#  -	Color: Diamond color from D (best) to J (worst)
#  -	Clarity: a measurement of how clear the diamond is
#  -	X: length in mm
#  -	Y: width in mm
#  -	Z: depth in mm
#  -	Depth: total depth percentage = z/mean(x,y)


##3.	Understanding Terminology that will be used in this PE and HW.
## a.	In a paragraph or two explain the concept of a confusion matrix and the theoretical process behind creating one in RStudio.

# Confusion Matrix is used to measure the accuracy and error rate of the prediction model. If the dependent variable to be classified contains 2 values, for example Spam & Not Spam, then the confusion matrix creates a 2x2 matrix with the values for the following cases:
#  i.	Number of times the email was spam and was classified correctly as spam by the model
#  ii.	Number of times the email was not spam and was classified correctly as not spam by the model
#  iii.	Number of times the email was spam but was incorrectly tagged as not spam by the model
#  iv.	Number of times the email was not spam but was incorrectly tagged as spam by the model 
# Increase in cases i. & ii. will improve the accuracy of the model whereas increase in iii. & iv. will result in an increase in error rate of the model
# The process of creating a confusion matrix in R is to create a Dataframe with 2 columns which are the actual value of the email type and the value classified by the model. For example if the actual value contains Spam & Non Spam, then the column with the value predicted by the SVM model contains 1s for non-spam predictions and 0 for spam predictions. Hence by creating a dataframe containing these 2 columns and then a contingency table using the table() function on the dataframe will produce the confusion matrix.

## HOMEWORK 10 

## Step 1:  Re-execute the Code Created in PE10.
## A.	Re-run the entire R code you created during the Prep Exercise. You might receive a warning message for both "kernlab" and "ggplot2" that 
##    reads "Updating Loaded Packages", select "No" and continue executing the code. 

diamonds_df <-diamonds
goodDiamonds <- diamonds_df[(diamonds_df$cut== "Premium" | diamonds_df$cut == "Ideal"),]
goodDiamonds$color <- as.numeric(goodDiamonds$color)
goodDiamonds$clarity <- as.numeric(goodDiamonds$clarity)
goodDiamonds$cut<-as.factor(as.character(goodDiamonds$cut))

## B.	Using the table() command, identify the total number of "Premium" and "Ideal" observations within the dataframe.
##    Record these observations in a comment. 

table(goodDiamonds$cut)
## There are 13791 Premium Diamonds and 21551 Ideal diamonds

## Step 2:  Creating training and test data sets. 
  ## A.	Generate a set of random indices that will allow you to choose cases for your training and data sets and assign it to a new variable name.
  ##    The range of your new indices should span from 1 to the final element index of the diamond subset data 
  ##    (35,342 if previous steps have been done correctly). 

 indicesrand <- sample(1:dim(goodDiamonds)[1])
 range(indicesrand)

 ## B.	Build a training dataset and test dataset. The training datatset should be two-thirds of the data, and the test dataset 
 ##     should be one third of the data.
 
 cut_point_two_thirds <- floor(2*dim(goodDiamonds)[1]/3)                     ## Creating the cut point value which is 2/3rd of the number of rows in df
 trainData <- goodDiamonds[indicesrand[1:cut_point_two_thirds],]              ## Out of the vector having indices in random order, we are filtering for 2/3rd of the indices and creating training dataset
 testData <- goodDiamonds[indicesrand[(cut_point_two_thirds+1):dim(goodDiamonds)[1]],]       ## Remaining 1/3rd of the indices are used to fetch rows from the datframe and create a test dataframe
 
 ## C.	Use the dim() command to demonstrate that the resulting training dataset and test data contain the appropriate number of cases. 

 dim(trainData)[1]                                           ## Number of rows in training dataset
 dim(testData)[1]                                            ## Number of rows in test dataset
 dim(testData)[1]/(dim(testData)[1]+dim(trainData)[1])       ## Proportion of rows in test data is 33.33% 
 dim(trainData)[1]/(dim(testData)[1]+dim(trainData)[1])      ## Proportion of rows in training data is 66.66%

## Step 3:  Build a support vector model. 
 ## A.	Create a support vector model based on the training dataset created in the previous step using the ksvm() function 
 ##     (or the train method, using the method svmRadial or svmLinear from the caret package). 
 ##     If needed, you can use the same parameters as shown on page 237 of the textbook. 
 ##     Parameters: kernal = "rbfdot", kpar = "automatic", C = 5, cross = , prob.model = TRUE
 
 svmOutput <- ksvm(cut ~., data = trainData, kernel = "rbfdot", kpar = "automatic", C = 5, cross = 3, prob.model = TRUE)

 ## B.	In a block comment, explain the above parameters. Be sure to thoroughly explain C = 5. 

 ## The ksvm function is used to build the support vector machine model. The first argument, "cut" means that we want to use the variable "cut" as our outcome variable.
 ## The ~ seperates LHS from RHS and the dot(.) means that we want to use all the other variables to predict cut and the data parameter is used to specify the dataframe being used.
 ## kernel is the customizable part of the model that helps project lower dimensional data to higher dimensions and rbf is the radial basis function. The rbf function takes inputs from the variables and calculates distance based on the combination of many variables in a row.
 ## The kpar argument helps control the operation of rbf function
 ## c value helps shape the fit of the model. By specifying a small value of C the margin of seperation  between the data points and the hyperplane will be large, but also the chances of error are high as a particular outcome can get classified incorrectly. On the other hand by specifying a 
 ##  large value of C will reduce the errors but also have very less margin between the datapoints and the hyperplane, thus resulting in overfitting.
 ## cross parameter is called k fold cross validation, which is used to avoid the problem of overfitting. By specifying k = 3, we are cross validating the model on 3 datasets therby making it more generalized and avoiding the chances of overfitting.
 
 
 ## C.	Store the output of the support vector machine function into a variable called svmOutput, and echo that variable to the console.  

 svmOutput
 
 ## Step 4:  Predicting values in the test data. 
## A.	Using the predict() function, validate the model against the test data. Assuming that your test data set is in a dataframe called testData, 
##    the call would be:
  
  svmPred <- predict(svmOutput, testData)

## B.	The object svmPred now contains a list of either "Premium" or "Ideal" cuts.

## C.	Using the str() and head() commands, review the contents of svmPred.
  
  str(svmPred)
  head(svmPred)

  ## Step 5:  Create a confusion matrix. 
## A.	Create a confusion matrix that compare the second row of svmPred to the contents of testData$cut.
  
  comp_table <- data.frame(testData[,2],svmPred)    ## Creating a dataframe containing the 2 columns (actual value in data & value predicted by the model)
  table(comp_table)                               ## Creating a contingency table to obtain confusion matrix.

## B.	Calculate an error rate based on what you see in the confusion matrix. If you are stuck refer to pages 243 - 244 in the textbook.

  ## The error rate is the number of cases where the model predicted the outcome incorrectly of the total number of case
  (539+389)/(539+389+4083+6770)
  ## The Error rate is ~ 7.8%
  
## C.	In a block comment, explain how good of a model you have built. 

  ## The model is very good because the error rate is as low as 7.8%, which means that the accuracy is as high as ~ 92%. i.e. the model is able to accurately classify and predict the output in 92% of the cases.

## Step 6:  Understanding the reasoning behind the practice.
## A.	In a block comment answer the following question. Why is it valuable to have a "test" dataset that is separate from a "training" dataset?
  
  ## It is valuable to have a separate training and test dataset to avoid the problem of overfitting. By building a model that is trained very well only on the training datset, will help predict the outcome with a very high accuracy on the training dataset, but will fail when a new dataset is provided as input.
  ## Hence, we need to ensure that the model predicts the outcome very well not only for one training dataset, but the model should also be able to preform well for new datasets such as the test dataset and thus the model has to be generalized enough to do well on a wide variety of datasets without having to compromise on accuracy.
  

