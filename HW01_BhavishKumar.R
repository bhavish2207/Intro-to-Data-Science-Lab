
# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 01
# Date due: 2nd SEPTEMBER 2019
#
# Attribution statement: (choose the statements that are true)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear all user objects from the environment!!!

# Set working directory 
# Change to the folder containing your homework data files
setwd("C:\\Users\\LENOVO\\Desktop\\SYR ADS\\Sem 1\\IST 687 Intro to Data Science")


### 4.

  height <- c(59, 60, 61, 58, 67, 72, 70)               ### Defining Vector Height
  weight <- c(150, 140, 180, 220, 160, 140,130)         ### Defining Vector Weight
  a <- 150                                              ### Defining Variable a

### 5.
### a.
  average_height = mean(height)                        ### Computing Average Height
  print(average_height)

average_weight = mean(weight)                        ### Computing Average Weight
print(average_weight)

### b.
  no_height_obs = length(height)                     ### Obtaining the number of values in height vector
  print(no_height_obs)
  
### c.  
  no_weight_obs = length(weight)                  ### Obtaining the number of values in weight vector
  print(no_weight_obs)

### d.
  sum_heights = sum(height)                       ### Obtaining the sum of all the values in height vector
  print(sum_heights)
  
### e.` 

  sum_weights = sum(weight)                        ### Obtaining the sum of all the values in weight vector
  print(sum_weights)
  
### f.
  avg_height_d_and_b = sum_heights/no_height_obs   ### Obtaining the average height without using the mean function  
  print(avg_height_d_and_b)
  
### g.
  avg_weight_e_and_c = sum_weights/no_weight_obs   ### Obtaining the average weight without using the mean function
  print(avg_weight_e_and_c)

### HOMEWORK 01 QUESTIONS
### STEP 2
  ### a.
  maxH <- max(height)               ### Obtaining the Maximum Height from the height vector
  maxH
  ### b.
  minW <- min(weight)              ### Obtaing the Minimum Weight from the weight vector
  minW  

### STEP 3
  ### a.
  extraWeight <- weight + 25         ### Adding 25 to all the values in the weight vector and creating a new vector
  extraWeight  
  ### b.
  average_extraWeight <- mean(extraWeight)    ### Obtaing the mean of the new vector extra weight
  average_extraWeight  

### STEP 4
  ### a.
  if(maxH > 70) "yes" else "no"              ### Checking if maximum Height is greater than 70
  ### b.
  if(minW > a) "yes" else "no"             ### Checking if minimum weight is greater than the value in variable a

### STEP 5
  ### a.
  bigHT <- height[height>60]            ### Creating a new vector bigHT by obtaining all the values > 60
  bigHT  
  ### b.
  smallWT <-weight[c(2,4)]            ### Creating a new vector smallWT by obtaining the 2nd & 4th value
  smallWT  
  ### c.  
  weight <- weight[c(-3)]             ### Excluding the 3rd element from the vector weight
  weight  
  ### d.
  ### height(3) generates an error because height is the name of a vector defined by the user and it is not a function.
  ### A paranthesis () can be used only with existing functions like sum(), mean() etc. 
  ### To pick elements from a vector square brackets [] need to be used instead of paranthesis.
  
  
### END OF HOMEWORK
  