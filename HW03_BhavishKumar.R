# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 03
# Date due: 16th SEPTEMBER 2019
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

### PREP EXERCISE 03
##1.	Getting the Data
  ## A.	Use R code to read directly from a URL on the web. Hint: use read.csv and url() to read the file from the web. 

   urlread <- "https://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv"

     ## B.	Store the dataset into a new dataframe, called dfStates. Hint: Use stringsAsFactors=FALSE.
   
   dfStates <- read.csv("Nst-est2011.csv", stringsAsFactors = FALSE)
   
  ## C.	The URL is: 
  ## https://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv
   
## 2.	Clean Up the Dataframe   
  ## A.	Use View( ), head( ), and tail( ) to examine the data frame. 
  ## Briefly describe what each of the commands show you about a dataframe in general and as it relates to this dataset.
   
   View(dfStates)
   ## The View Command shows us the entire dataframe and all the rows and columns   
   
   head(dfStates)
   ## This head command returns the headers along with the first 6 rows of the dataframe
   
   tail(dfStates)
  ## The tail command returns the header rows along with the last 6 rows of the dataframe
   
   
  ## B.	Remove unneeded rows by using the minus sign in the row selector of the [ , ] subsetting method. 
  ## Hint: Start by removing extra rows that appear at the end of the data set.

   dfStates1 <- dfStates[-60:-66,]
   dfStates2 <- dfStates1[-1:-8,]     ## Removing Unnecessary Rows to create dfStates2 dataframe
   
  ## C.	Use the dim() command to make sure there are exactly 51 rows (one per state + the district of Columbia).
   
   dim(dfStates2)
View(dfStates2)


### D.	Remove unneeded columns by using the minus sign in the column selector of the [ , ] subsetting method. 

  dfstates3 <- dfStates2[,-6:-10]     ### Removing Unnecessary columns

### E.	Use the dim() command to make sure there are precisely five columns.
    
    dim(dfstates3)
     View(dfstates3)   
     
### 3.	Let's add some meaningful metadata!
  ## A.	Rename the columns with the following names: stateName, Census,  Estimated, Pop2010, Pop2011. Hint: use colnames( )
    
    newcolnames <- c("stateName", "Census",  "Estimated", "Pop2010", "Pop2011")      
    colnames(dfstates3) <- newcolnames   ### Renaming the existing column names to new more intuitive column names
    
### 4.	More cleansing! 
  ## A.	Use gsub(",", "", vectorName) to remove the commas from each column of numeric data. Place the converted results back into the data frame.
    
    stateNameCleaned <- gsub(",","",dfstates3$stateName)
    CensusCleaned <- gsub(",","",dfstates3$Census)
    EstimatedCleaned <- gsub(",","",dfstates3$Estimated)
    Pop2010Cleaned <- gsub(",","",dfstates3$Pop2010)
    Pop2011Cleaned <- gsub(",","",dfstates3$Pop2011)
    
    dfstates4 <- data.frame(stateNameCleaned,CensusCleaned,EstimatedCleaned,Pop2010Cleaned, Pop2011Cleaned)
    View(dfstates4)
    str(dfstates4)
  
  ## B.	 Use as.numeric( ) to coerce each numeric data column into numbers. Place the converted results back into the data frame
    
    dfstates4$CensusCleaned <- as.numeric(dfstates4$CensusCleaned)
    dfstates4$EstimatedCleaned <- as.numeric(dfstates4$EstimatedCleaned)
    dfstates4$Pop2010Cleaned <- as.numeric(dfstates4$Pop2010Cleaned)
    dfstates4$Pop2011Cleaned <- as.numeric(dfstates4$Pop2011Cleaned)             ## To convert factor datatype variables to numeric datatype
    
    
  ## C.	Calculate the mean of the 4 numeric variables and fill in the table below:
      
      ## Census	
    mean(dfstates4$CensusCleaned)               ### To get Mean of the following 4 numeric variable
    
    ##Estimated	
    mean(dfstates4$EstimatedCleaned)            
    
    ## Pop2010	
    mean(dfstates4$Pop2010Cleaned)
    
    ## Pop2011	
    mean(dfstates4$Pop2011Cleaned)
    

### HOMEWORK 03
    ### Step 1:  Using your R code from the weekly Prep Exercise find the states with the largest and smallest populations.
    
    ##A.	Create a function, call readStates(), that returns the cleaned dataframe of the states population (i.e. executes all of your R-code from the Prep work, but within a function so that we can load the states dataset anytime we want).
    
    readStates <- function(inputDataFrame) {
      inputDataFrame1 <- inputDataFrame[-60:-66,]
      inputDataFrame2 <- inputDataFrame1[-1:-8,]                 ## Removing Unnecessary Rows
      inputDataFrame3 <- inputDataFrame2[,-6:-10]                ## Removing Unwanted Columns
      
      newcolnames <- c("stateName", "Census",  "Estimated", "Pop2010", "Pop2011")      
      colnames(inputDataFrame3) <- newcolnames   ### Renaming the existing column names to new more intuitive column names
      
      stateNameCleaned <- gsub(",","",inputDataFrame3$stateName)
      CensusCleaned <- as.numeric(gsub(",","",inputDataFrame3$Census))
      EstimatedCleaned <- as.numeric(gsub(",","",inputDataFrame3$Estimated))
      Pop2010Cleaned <- as.numeric(gsub(",","",inputDataFrame3$Pop2010))
      Pop2011Cleaned <- as.numeric(gsub(",","",inputDataFrame3$Pop2011))
      
      dfStates <- data.frame(stateNameCleaned,CensusCleaned,EstimatedCleaned,Pop2010Cleaned, Pop2011Cleaned)
      rownames(dfStates) = NULL
      return(dfStates)
    }
    
    ##B.	Use your newly created function to create a new dataframe, called dfStates.
    
    dfStates <- readStates(dfStates)  ### Creating a new dataframe called dfStates using the newly created function
    
    ##C.	Using the Pop2011 column within dfStates, calculate the minimum, mean, and maximum population of the states.
    
    print(min(dfStates$Pop2011Cleaned))   ### 568158 is the minimum 2011 population that any state has
    print(max(dfStates$Pop2011Cleaned))   ### 37691912 is the maximum 2011 population
    print(mean(dfStates$Pop2011Cleaned))  ### 6109645 is the mean 2011 population
    
    ##D.	Use which.max() on the data from the Pop2011 column to find the row that contains the largest state. 
       ###  How can you use the results of your which.max() expression to output just the name of the state?
    
    dfStates[which.max(dfStates$Pop2011Cleaned),]    ### USing which.max() To obtain the row that contains the largest state California
    
    dfStates[which.max(dfStates$Pop2011Cleaned),"stateNameCleaned"]  ### Using the which.max() and slicers to obtain just the State Name (California) 
                                                              
    
    ##E.	Use which.min() on the data from the Pop2011 column to find the row that contains the smallest state. 
       ### How can you use the results of your which.min() expression to output just the name of the state?
    
    dfStates[which.min(dfStates$Pop2011Cleaned),]   ### Using which.min() to obtain the row that has the smalles state Wyoming
    print(dfStates[which.min(dfStates$Pop2011Cleaned),"stateNameCleaned"])   ### Using which.min() and slicers to obtain just the state name Wyoming
      
    ### Step 2:  Sort the data frame by population size using the Pop2011  numeric column
    ##A.	Store the results in a new dataframe called dfStatesOrdered.
    
  dfStatesOrdered <- dfStates[order(dfStates$Pop2011Cleaned, decreasing = TRUE),]  ### Sorting the dataframe in descending order of 2011 population
  View(dfStatesOrdered)  
  
    ### Step 3:  Creating a Plot
    
    ## A.	Create a histogram of one of the numeric columns from the sorted dataframe, what do you observe?
  
    hist(dfStatesOrdered$Pop2011Cleaned)
    ### From the above histogram we can observe that the 2011 population data is right skewed with a couple of states having a very high population that is much larger than the mean population. 

       