# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 04
# Date due: 23rd SEPTEMBER 2019
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

### PREP EXERCISE 04

  ### 1.	Create a Function
      ## A.	Create a new function 'printVecInfo' and have it take one numeric vector as its input argument. Here's a shell of the function:
  
  printVecInfo <- function(numVector)
  {
    # Use print( ) inside of a function when you want some output
    # to appear on the console.
    print(mean(numVector) )
    
  }
      test <- c(1,2,3,4,5)
      printVecInfo(test)


     ## B.	Make the function print all of the following information for the vector supplied in the argument:
      
        ### a.	Mean (hey great that is already in the sample above!)
        ### b.	Median
        ### c.	Min and Max
        ### d.	Standard Deviation
        ### e.	0.05 and .95 quantiles  Hint: use the quantile( ) function.
                
           printVecInfo <- function(numVector)
           {
            # Use print( ) inside of a function when you want some output
            # to appear on the console.
            print(mean(numVector))        ### Printing the mean of the vector
            print(median(numVector))      ### Printing the median of the vector
            print(min(numVector))         ### Printing Min value of the vector
            print(max(numVector))         ### Printing Max value of the vector
            print(sd(numVector))          ### Printing std deviation of the vector
            print(quantile(numVector, probs = c(0.05,0.95)))          ### Printing 5th and 95th percentile values
            }
        printVecInfo(test)
           

 ### 2.	Let's Test the Function and Add some Helpful Labels
    ## A.	Test the function with this vector. 
        
        testVector <- (1:10)
  
      ### a.	Did you get 5.5, 10, 1, 3.02765, 5% 1.45 95% 9.55? If not, check your work.
             
        printVecInfo(testVector)
        
      ### B.	Now let's make that output easier to read. Add labels to each element of the function's output. 
          ### Hint: You might want to use paste0 in your function or switch from the print() command to the cat() command in your function.
        
        printVecInfo <- function(numVector)
        {
          # Use print( ) inside of a function when you want some output
          # to appear on the console.
          cat("vector mean is: ",print(mean(numVector)))        ### Printing the mean of the vector
          cat("vector median is: ",print(median(numVector)))      ### Printing the median of the vector
          cat("Min value of vector is: ",print(min(numVector)))         ### Printing Min value of the vector
          cat("Max value of vector is: ",print(max(numVector)))         ### Printing Max value of the vector
          cat("Standard Deviation of vector is: ",print(sd(numVector)))          ### Printing std deviation of the vector
          cat("5th and 95th percentile are: ",print(quantile(numVector, probs = c(0.05,0.95))))          ### Printing 5th and 95th percentile values
        }
        
      ### C.	Repeat step 2.a again. Place a print screen of the results below.
        
        printVecInfo(testVector)

        
  ### 3.	Explore the dataframe!
       ## A.	For this week's homework we'll practice sampling using a built-in data frame called airquality. 
       ##     Copy the dataframe into a new dataframe called myAQdata.
        
        myAQdata <- airquality
      
       ## B.	Using the VIEW command, explore the data. You may also want to use the ?command. 
       ##     You may even have to do additional research to help you understand the elements of the dataset. 
        
       View(myAQdata)     ### VIEW Command to explore the data
       summary(myAQdata)  ### Also using the summary and str commands to further explore the data in more detail
       str(myAQdata)
        
       ## C.	Please use your own words to describe the different elements of the dataset and 
       ##     their values based on the first 5 rows of the dataframe.
        ### The dataset has 6 numeric columns which are Ozone, Solar, Wind, Temperature, Month and Day. 
        ### The first 5 rows shows us the Ozone, Solar, Wind and Temperature values for the first 5 days of the fifth month.
        ### We can observe that the there may be some kind of liner relationship between ozone and wind.
       
       
 ### HOMEWORK
       ## STEP 1
       ### A.	The last line from your Prep Ex efforts should be 
           myAQdata <- airquality ## followed by 
           View( myAQdata)  
       
       ### B.	Execute the following command. myAQdata$Ozone[is.na(myAQdata$Ozone)] 
          
       myAQdata$Ozone[is.na(myAQdata$Ozone)]
       
       ### C.	Write a comment describing the results and how that statement works.  
       ###    You may want to run the command is.na(myAQdata$Ozone), or you may want to do a view of your dataframe to try to understand what 
       ###    the command does. Describe your understanding below.
       
       # The is.na() function returns the TRUE or FALSE flags for all the elements of a vector based on whether the values are present or missing.
       # i.e. it indicates missing elements from a vector or a column by indicating all the missing values with a TRUE flag.
       # The is.na(myAQdata$Ozone) indicates the indices of all the missing elements with a TRUE flag and the myAQdata$Ozone[is.na(myAQdata$Ozone)] returns all the NA values in the column Ozone.
       
       
       ### D.	Adapt that statement above to assign the mean of the Ozone variable to these missing values.  
       ###    First, you'll want to calculate the mean of all of the Ozone instances. 
       ###    Reminder: you'll have to do this by omitting the ones with an NA. (HINT: use na.rm=TRUE within the mean function).  
       ###    You should have both sides of the equation now (A <- C).  
       
       mean_ozone = mean(myAQdata$Ozone, na.rm = TRUE)      ## Calculating the mean of Ozone column by omitting all the NA's
       myAQdata$Ozone[is.na(myAQdata$Ozone)] <- mean_ozone   ## Assigning the mean value to all the NAs
       
       ### E.	Perform the same task on the one other variable that needs it (i.e., is there another column with NAs)? 
       
       myAQdata$Solar.R[is.na(myAQdata$Solar.R)]                ## Solar is another column that has NA's
       mean_solar = mean(myAQdata$Solar.R, na.rm = TRUE)        ## Calculating the mean of Solar by omitting all the NA's
       myAQdata$Solar.R[is.na(myAQdata$Solar.R)] <- mean_solar  ## Assigning mean value to all the NA's
        
         
      ## Step 2: using a package to replace NAs
      ### A.	Install the package imputeTS  by doing the following commands:
         
         install.packages("imputeTS")
         library(imputeTS)
       
      ### B.	Note that you only have to do the install.packages once, but you might have to library every time you are running 
      ###     the code in a clean environment.
       
      ### C.	Now, create myAQdata1, and then use the na_interpolation( ) function, 
      ###     instead of mean substitution in your four variables. Don't forget to rerun Step 1.A, 
      ###     because if you have already done mean substitution successfully there will not be any NAs left in 
      ###     the myAQdata data frame for na_interpolation( ) to work on.
         
         myAQdata1 <- na_interpolation(myAQdata)
       
      ### D.	Compare the first 5 rows of myAQdata and myAQdata1. In a block comment, explain what you see.
       
        View(myAQdata1)
        View(myAQdata)
        ### Comparing the first 5 rows values of myAQdata whose NA values were treated using mean and myAQdata1 whose NA values were treated by interpolation.
        ### interpolate takes the mean of the previous two values and replaces the NA value which is a better approach to treat missing values in comparison
        ### to replacing it with the mean of the entire column.   
       
    ## Step 3: Sampling
      ### A.	Sample 10 observations from myAQdata$Wind and use printVecInfo( ) to display the characteristics of the resulting sample. 
      ###     Next display those 10 observations via a histogram. In a comment, describe the purpose of an optional argument that you 
      ###     can supply to sample( ), replace=FALSE or replace=TRUE (and what was the value when you did the sample).
       
        Wind_sample_10 <- sample(myAQdata$Wind, size = 10, replace = TRUE)   ### Taking a sample of size 10 from wind column
        printVecInfo(Wind_sample_10)                                         ### displaying the characteristics using the wind function
        hist(Wind_sample_10)                                                 ### histogram for the sample
        ### The argument replace = TRUE will ensure that the same value can appear twice while sampling as the value is replaced whereas 
        ### replace = FALSE will ensure that the same value will not repeat again.    
            
      ### B.	Repeat what you did for Question 1.A three additional times. Each time that you create a new sample, 
      ###     run the resulting data through printVecInfo( ) and generate a histogram. Explain in a block comment why each result is different.
        
        Wind_sample_10_one <- sample(myAQdata$Wind, size = 10, replace = TRUE)   ### Taking a sample of size 10 from wind column
        printVecInfo(Wind_sample_10_one)                                         ### displaying the characteristics using the wind function
        hist(Wind_sample_10_one)
        
        Wind_sample_10_two <- sample(myAQdata$Wind, size = 10, replace = TRUE)   ### Taking a sample of size 10 from wind column
        printVecInfo(Wind_sample_10_two)                                         ### displaying the characteristics using the wind function
        hist(Wind_sample_10_two)
        
        Wind_sample_10_three <- sample(myAQdata$Wind, size = 10, replace = TRUE)   ### Taking a sample of size 10 from wind column
        printVecInfo(Wind_sample_10_three)                                         ### displaying the characteristics using the wind function
        hist(Wind_sample_10_three)
    ### The three results are different because the sample function randomly generates a different vector of size 10 each time 
    ###    you run the sample function. Hence no two samples will be the same.
        
           
    ## Step 4:  Replicating our samples
      ### A.	 Use the replicate function, to replicate the sampling of Wind (the sampling that was described above) combined with 
      ###      calculating the mean of the sampled Wind attribute. Replicate the sampling and mean calculation 200 times, 
      ###      then display the results of the 200 means as a histogram.
      ###      If you need a hint, see Chapter 10 in the book.
        
          hist(replicate(200, mean(sample(myAQdata$Wind, size = 10, replace = TRUE)), simplify = TRUE))
                               ### Obtaining the mean of the sample of size 10 and replicated this 200 times to using the replicate function to obtain 200 means and then 
                               ### plotted an histogram of the 200 means
          
       
      ### B.	Repeat step 4A two more times. 
          hist(replicate(200, mean(sample(myAQdata$Wind, size = 10, replace = TRUE)), simplify = TRUE))
          hist(replicate(200, mean(sample(myAQdata$Wind, size = 10, replace = TRUE)), simplify = TRUE))
          
      ### C.	Using a block comment, explain why the histograms generated in Step 1 are different than the histograms generated in Step 3
          
          ### The histograms generated in step 3 do not follow normal distribution as we have taken a sample of only size 10 which is a small sample.
          ### In step 4 we are replicating the sampling 200 times thereby obtaining a large sample, 
          ### hence we can observe that the sample follows Normal distribution as per central limit theorm, as the sample size is large.
      
       
        
    
        