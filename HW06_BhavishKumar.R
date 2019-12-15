# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 06
# Date due: 7th OCTOBER 2019
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

### PREP EXERCISE 06

## Step 1:  Use the merge command to create a new dataframe
  ### A.	Code and Execute the following block of code. Be sure to understand each line. 
  ###     As a reminder, you created the 'readStates' function in a previous homework assignment, so you should be able to reuse that code. 
  ###     Add comments before each line to explain in detail what each line of code does.

dfStates <- read.csv("Nst-est2011.csv", stringsAsFactors = FALSE)  ### Reading from a CSV and storing the table into a R dataframe

readStates <- function(inputDataFrame) {               ### using the same readStates function that was used in Homework 3 to take a dataframe as input and clean it up 
  inputDataFrame1 <- inputDataFrame[-60:-66,]
  inputDataFrame2 <- inputDataFrame1[-1:-8,]                 ## Removing Unnecessary Rows
  inputDataFrame3 <- inputDataFrame2[,-6:-10]                ## Removing Unwanted Columns
  
  newcolnames <- c("stateName", "Census",  "Estimated", "Pop2010", "Pop2011")      
  colnames(inputDataFrame3) <- newcolnames   ### Renaming the existing column names to new more intuitive column names
  
  stateName <- gsub(",","",as.character(inputDataFrame3$stateName))
  CensusCleaned <- as.numeric(gsub(",","",inputDataFrame3$Census))
  EstimatedCleaned <- as.numeric(gsub(",","",inputDataFrame3$Estimated))
  Pop2010Cleaned <- as.numeric(gsub(",","",inputDataFrame3$Pop2010))
  Pop2011Cleaned <- as.numeric(gsub(",","",inputDataFrame3$Pop2011))       ### Cleaning the columns and creating a new dataframe
  stateName <- sub(".","",stateName)                                       ### Removing the . from the values in stateName column
  dfStates <- data.frame(stateName,CensusCleaned,EstimatedCleaned,Pop2010Cleaned, Pop2011Cleaned)
  rownames(dfStates) = NULL
  return(dfStates)
}

states <- readStates(dfStates)       ### Obtaining the cleaned dataframe output returned from the readStates function that was used in HW03 and storing it in states dataframe
arrests <- USArrests                 ### Creating a new dataframe 'arrests' that contains USArrests data
arrests$stateName <- rownames(arrests)    ### Creating a new 'stateName' column in the arrests dataframe that contains the rownames of the dataframe
mergeDF <- merge(states,arrests,by.x = "stateName", by.y = "stateName")   ### Merging the 2 dataframes on stateName column to create a new dataframe that has columns from both the tables 


## Step 2:  Use ggplot to start to explore our merged dataframe
   ### A.	Install and library the ggplot2 package.

        ## install.packages("ggplot2")
        ## library("ggplot2")

   ### B.	Code and Execute the following block of code (actually type, do not copy/paste). 
   ###    Add comments before each line to explain in detail what each line of code does. Add an appropriate title for the chart (using 'ggtitle')

     ggplot(mergeDF) +    ### This is to create a ggplot with the mergeDF dataframe
       aes(y=Murder) +    ### Using the murder column of the dataframe as Y axis
       geom_boxplot() +   ### Specifying that we want to produce a boxplot using the Murder column
       ggtitle("Murders")  ### Providing a title for the Boxplot
  
  ### C.	Cut and paste an image of the visualization created by the ggplot and explain what you see

     ### quantile(mergeDF$Murder, probs = c(0.25,0.5,0.75))
     ### From the above boxplot we can observe that the median (50th percentile) value for murders is around 7.25 and the 25th and 75th percentile values 
     ### are around 4 and 11 respectively. 
     ### Using this we can measure the interquartile range. We can also observe the smallest and largest values too.
     
  ### D.	Code and Execute the following block of code (actually type, do not copy/paste). 
  ###     Add comments before each line to explain in detail what each line of code does. Add an appropriate title for the chart (using 'ggtitle')

 myPlot <- ggplot(mergeDF, aes(x=Murder))       ### Creating a ggplot with mergeDF dataframe and using Murder column in X axis.
 myPlot <- myPlot + geom_histogram(binwidth=2, color="black", fill="white")   ### Producing a black bordered histogram filled with white color of Murders with binwidth 2 (i.e. shows the frequency of murders between 1 to 3, 3 to 5 and so on) 
 myPlot <- myPlot + ggtitle("Murders Histogram")   ### Adding a title to the histogram
 myPlot            ### Viewing the histogram

 ### E.	Cut and paste an image of the visualization created by the ggplot and explain what you see

    ### We can observe the histogram of murder rate column which follows a normal distribution having 2 peaks (bi modal). We can observe that murder rate between 7 to 9 has maximum number of states and there is another peak between 11 to 13.
 
 ### END OF PREP EXERCISE 6
 
### HOMEWORK 6
 
 str(USArrests)
help("USArrests") 
 