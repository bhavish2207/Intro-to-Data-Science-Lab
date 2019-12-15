# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 05
# Date due: 30th SEPTEMBER 2019
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

### PREP EXERCISE 05

  ## 1.
    ### A. For this week's homework we'll practice be using vehicle accident data from the State of Maryland. 
    ### First, get the following lines of code to work, you might need the following packages installed and libraried: RCurl, jsonlite.
    ### install.packages("RCurl")
    ### library("RCurl")
    ### install.packages("jsonlite")
    ### library("jsonlite")
dataset <- getURL("http://opendata.maryland.gov/resource/pdvh-tf2u.json")
df <- jsonlite::fromJSON(dataset)


  ## 2.
   ### A.Using the VIEW command, explore the data. You may also want to use the ?command. 
   ###   You may even have to do additional research to help you understand the elements of the dataset.

   View(df)
   ?df
  str(df)
  summary(df)
  
  ### B. What does getURL function do?
  ## getURL function is part of the RCurl package that is used for retrieving the source of a webpage that helps in scrapping data from a webpage.
  ## The JSON structure of a webpage can be obtained using the getURL function.
  
  ### C.	Describe why we use fromJSON.
  ## fromJSON function is used to convert the data from JSON format to R object format, i.e. to the format of a dataframe.
  
  ### D.	How many accidents are in the dataset?
  length(unique(df$case_number))   ### returns the number of unique values in the column case_number of the dataframe df
  length(df$case_number)           ### returns the number of values in the column case_number
  
  
  ### E.	Provide a brief summary of df and show a screen capture of str(df) or glimpse(df).
  ## The dataframe df has 1000 rows and 18 columns which are case_number, acc_date, acc_time, day_of_week etc. 
  ## This dataframe contains information about various accidents that took place across the state.
  str(df)
  glimpse(df)
  View(df)

  ### HOMEWORK 05
  
  ## STEP 1
   ### A. Document the following R code, with a comment for each line and explain, via a comment, what question the code answers
  df$vehicle_count <- as.numeric(df$vehicle_count)    ### This code converts the datatype of vehicle count column to numeric data type
  value <- df %>%                                     ### Creating a new variable called 'value' and copying the resultant mean from dataframe 'df' after executing codes below using pipes
    filter(str_trim(day_of_week)=="THURSDAY") %>%     ### Filtering out rows with day_of_week value as 'THURSDAY' after trimming of leading and trailing spaces from the value by applying the str_time() function.
    pull(vehicle_count) %>%                           ### Selecting the vehicle_count column from the filtered dataset
    mean(na.rm=TRUE)                                  ### Calculating the mean of the selected column by excluding the 'NA' values using the na.rm command    
  
  
  value <- mean( df$vehicle_count[str_trim(df$day_of_week)=="THURSDAY"], na.rm=TRUE)  ### Calculating mean of vehicle_count column after filtering for 
                                                                                      ### "THURSDAY" by trimming the spaces and excluding the "NAs" and saving in variable value

  ### Step 2:  Investigating the data frame by answering the following questions with explicit R code, 
  ###          and make sure you handle NAs (in any way you think is appropriate):
  
    ### A.	What was the total number of accidents with injuries?
  
             ### install.packages("sqldf")
             ### library("sqldf")
            ### library("tidyverse")
             accidents_w_injuries <- df %>%                                       ### from dataframe 'df' filtering for accidents with injuries and then taking the count
                                     filter(str_trim(injury) == "YES") %>%
                                     summarise(count = n())
             accidents_w_injuries                                             ### 301 accidents with injuries
             
             
    ### B.	How many accidents happen on Friday? 
             
             accident_on_fri <- df %>%                        ### from dataframe 'df' filtering for accidents on friday and then taking the count
               filter(str_trim(day_of_week) == "FRIDAY") %>%
               summarise(count = n())
             accident_on_fri                                             ### 151 accidents on Friday
             
    ### C.	What is the total number of accidents on Friday where injury='YES'?
             
             accident_on_fri_w_injuries <- df %>%                        ### from dataframe 'df' filtering for 
               filter(str_trim(day_of_week) == "FRIDAY") %>%             ### accidents on friday with injuries and then taking the count     
               filter(str_trim(injury) == "YES") %>%
               summarise(count = n())
             accident_on_fri_w_injuries                          ### 49 accidents on Friday with injuries
             
    ### D.	What is the total number of accidents on Friday where injury ='NO'?
             
             accident_on_fri_wo_injuries <- df %>%                        ### from dataframe 'df' filtering for 
               filter(str_trim(day_of_week) == "FRIDAY") %>%             ### accidents on friday without injuries and then taking the count     
               filter(str_trim(injury) == "NO") %>%
               summarise(count = n())
             accident_on_fri_wo_injuries                          ### 102 accidents on Friday without injuries
             
    ### E.	How many injuries occurred each day of the week?
             
             injuries_each_day_week <- df %>%                 ### from dataframe 'df' filtering for 
               filter(str_trim(injury) == "YES") %>%          ### accidents with injuries and then grouping by day of the week and taking the count of number of injuries on each day      
               group_by(day_of_week) %>%
               summarise(count = n())
             injuries_each_day_week               ### 49 injuries on Friday, 41 on Monday, 42 on Saturday etc.
             
    ### F.	Create a new data frame that only includes accidents on Friday.  
             
          df_accidents_on_friday <- df %>%                 ### from dataframe 'df' filtering for 
            filter(str_trim(day_of_week) == "FRIDAY")         ### accidents occuring on Friday and creating a new dataframe      
            View(df_accidents_on_friday)
             
    ### G.	What is the mean number of vehicles involved in accidents on Friday?
            
            mean(as.numeric(df_accidents_on_friday$vehicle_count), na.rm = TRUE)       ### Using New Dataframe that has only accidents of Friday 
                                                                                       ### and calculating mean of vehicle count by excluding nulls
            
    ### H.	Use hist( ) to make a histogram of the number of vehicles in accidents on Friday.
            
            hist(df_accidents_on_friday$vehicle_count)                              ### Histogram of number of vehicles on friday shows that majority of the cases have 2 vehicles followed by 1 vehicle
            
    ### I.	What is the distribution of the number of vehicles in accidents on Sunday (use a histogram and quantile)
            
            df_accidents_on_sunday <- df %>%                      ### from dataframe 'df' filtering for accidents occuring on Sunday and creating a new dataframe
              filter(str_trim(day_of_week) == "SUNDAY")
            hist(as.numeric(df_accidents_on_sunday$vehicle_count))            ### Histogram with number of vehicles involved in accident on Sunday
            abline(v = quantile(as.numeric(df_accidents_on_sunday$vehicle_count),0.05, na.rm = TRUE))        ### Using abline to mark the 5th & 95th percentile values on the histogram
            abline(v = quantile(as.numeric(df_accidents_on_sunday$vehicle_count),0.95, na.rm = TRUE))
            
            fifth_ninetyfifth_perc <- quantile(as.numeric(df_accidents_on_sunday$vehicle_count), probs = c(0.05,0.95), na.rm = TRUE)   ### Obtaining the 5th & 95th percentile values from the vehicle count column for vehicles involved in accident on sunday           
             
            fifth_ninetyfifth_perc               ### 1 car is the 5th percentile value and 3 cars is the 95th percentile value
            
    ### J.	Add a block comment explaining how the distribution on Sunday compares with the distribution of the number of vehicles in accidents on Friday 
  
     ### On Friday majority of the accidents (more than 60 accidents) involve 2 cars and around 40 accidents involve 1 car and there are upto 20 cases involving 3 cars as well. Whereas the opposite is true for Sunday.
     ### On Sunday majority of the cases (more than 50) involve just 1 car and lesser number of cases (around 30) involve 2 cars and very few cases (around 5) involve 3 cars.
  