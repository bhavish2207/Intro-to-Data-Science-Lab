# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 09
# Date due: 4th NOVEMBER 2019
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

### PREP EXERCISE 09

### 1.	Getting Ready: Loading and Verifying the Titanic Dataset

## a.	An R dataset containing the titanic data is available on the Blackboard site. Download it to your computer and use the load() command 
##    to bring it into your RStudio environment.

  load("titanic.raw.rdata")

## b.	If you are having trouble using the load() command, make sure you downloaded the titanic data to your working directory. You can check what is your working directory in R using the code below: 
##    getwd()

  ### Directory was set to working directory before loading
  
## c.	Load the imported data into a dataframe called "badboat".

badboat <- data.frame(titanic.raw)

## d.	Run the View() command to verify that the dataframe has been loaded correctly and place a screenshot of the dataset below 
##    (do not worry about screenshotting the entire dataframe, a portion will do).

  View(badboat)

  
  ## 2.	Understanding Terminology that will be used in this PE and HW.
    ## a.	In a paragraph or two explain the concept of a sparse matrix and how to identify whether or not data is a sparse matrix.  
  
  ## A matrix is a data structure that has rows and columns like a datframe. A matrix is called sparse if only very few columns have occur frequently in all the rows, i.e. only few columns have a value 1 under a large proportion of rows or have high support. In other words if there are more than 50% 0s in the entire matrix then it is called a Sparse Matrix.
  
    ## b.	In a few sentences explain what a dense matrix is and its defining feature.
  
  ## A dense matrix is the opposite of a sparse matrix where the number of 1s in the entire matrix is more than the number of 0s, i.e. a large number of columns have value 1 under them.
  
    ##  c.	Explain contingency tables and how you would go about creating one in RStudio (if needed, you can google "contingency table in r", there are many resources on the web). How would you go about reading /understanding a contingency table?
  
   ## A contingency table is a confusion matrix that shows the Joint Distribution of categorical variables. The table() function with 2 arguments can be used to create a contingency table in R. For example table(cars$type, cars$origin) will yield a contingency table with the first argument cars$type being the row variable and second argument cars$origin will be the column variable.
  
  ## 3.	Loading Necessary Packages.
    ## a.	In the homework portion of this week's lesson you will need two packages; arules and arulesViz.
  
    ## b.	Install both packages and check/update them using the library() command to ensure the packages exist.
     ##   Paste a screenshot of the code and respective output below.
  
  install.packages("arules")
library(arules)  
  
  install.packages("arulesViz")
  library(arulesViz)
  
  
### HOMEWORK 09
  
  ##Step 1:  Explore the Data Set.
  ### A.	Re-run the View() command to examine the badboat dataframe; write a block comment describing what you see. Is this a sparse matrix?

  View(badboat)
  ## This badboat is a dataframe and hence it is not a sparse matrix. A dataframe can be converted into a matrix form 
      
  ### B.	Using the table() command, count the people in each category of the Survived variable. At a high-level, describe what you see in a comment. 
  
  table(badboat$Survived)
  ## The table command tells us the number of occurences of each category in the mentioned vector. Here "No" occurs 1490 times and "Yes" occurs 711 times in the Survived variable.
  ## This means that 1490 people did not survive and 711 people survived.
  
  
  ### C.	Express the results of part B as percentages by sending the results of the table() command into the prop.table() command. 
  
  100*prop.table(table(badboat$Survived))
  ## The above numbers obtained using the table() function were passed to the prop.table function to obtain the proportion under each category.
  ## Here 67.6% of the people did not survive and 32.3% of the people survived.
  
  
  ### D.	Following the same techniques used in the previous tasks, show the percentages for Class, Sex, and Age variables. 
  
  100*prop.table(table(badboat$Class))
  ## 14.76% of people in first class, 12.94% of people in second class, 32% in third class and 40% in Crew
  
  100*prop.table(table(badboat$Sex))
  ## 21.3% were females and 78.64% were males
  
  100*prop.table(table(badboat$Age))
  ## Approximately 95% of the passengers were adults and 5% were children
  
  ### E.	Show a contingency table of percentages for the Age and Sex variables together. Write a block comment of your observations. 
  
  100*prop.table(table(badboat$Age,badboat$Sex))
  ## We created a contingency table of percentages for Age and Sex variables together. We can observe that of the total number, approximately 19% are Female Adults, 76% are Male Adults, 3% are Male children and 2% are Female Children.
  
  
 ##Step 2:  Coercing the data frame into transactions. 
  
  ### A.	Coerce the badboat dataframe into a sparse transactions matrix using the code provided below. 
  ###     Comment what the components of the code tell RStudio to do. 
  
  badboatX <- as(badboat,"transactions")
  ### The as() function converts the dataframe to transactions class. Sparse Matrix format is transactional data. The as() function is used to convert and the data type is specified as "transactions".
  ### By doing so every category under each column appears as a separate column with every occurences of that cateogry (transaction) appearing as 1/0 under the column.
  
  ### B.	Using the inspect(), itemFrequncy(), and itemFrequencyPlot() commands, explore the contents of "badboatX". 
  ###     Write a comment about what each of the commands does.
  
  inspect(badboatX)
  ## The Inspect function lets us to view certain occurences in the matrix
  
  itemFrequency(badboatX)
  ## The itemFrequency() function gives us the percentage of occurence of each category under the different columns.
  ## In this case there are 21% Females and 79% Males, 95% Adults and 5% Children and so on.
  
  itemFrequencyPlot(badboatX, support = 0.1)
  ## The itemFrequencyPlot() command is used to plot a frequency bar plot of each category by filtering out all the cases that have support greter than 10%.
  ## i.e the category occurs more than 10% of the times. In this case every other category has support greater than 10% except for Age = Child because there are only 5% children.
  
  ### C.	Explore the spare matrix data object using the View() command and write a comment about your observations.  
  
  View(badboatX)
  ## Using the View(badboatX) command gives us information on the data under the data section, i.e number of rows and columns, in this case we can see that there are 2201 rows for 2201 passengers and 10 columns for all the categories.
  ## The itemInfo section tells us about all the categories present under each column. For example, in this case, we have 1st, 2nd, 3rd & Crew classes and Male and Female sexes and Adult and Child Age groups followed by Yes and No categories for survival status.
  
  
  ### D.	In a few sentences, write a block comment explaining the difference between "badboat" and "badboatX".
  
  ## The badboat is a datframe that has 4 columns which are Class, Sex, Age and Survived and all the 4 columns are categorical variables, with each row containing the categorical values under the corresponding columns.
  ## The badboatX is a spare matrix which is a transactional data object obtained by creating columns out of each category. i.e. the values Male, Female, Adult, Child, No & Yes appear as columns with 1/0 values under the columns.
  ## i.e. for example if an individual is a Male, Adult, 1st Class passenger who survived, then the values under 1st, Male, Adult and Yes will be 1 and value under every other column will be 0. 
  
  ## Step 3:  Discovering patterns using associated rules mining.
  ### Before beginning this section, it is important to understand that support is the proportion of times that a particular 
  ### set of items occurs relative to the whole dataset. Confidence is the proportion of times that the consequent occurs when the antecedent is present. 
  ### In layman's terms, confidence is the proportion of times that we observe the result given the preceding event has occurred. 
  
  ### A.	Run the block of code below. Document, via comments,  what each line of code does (the comments should be before each line of code below). 
  ###     Make sure that you are typing the code in RStudio, do not copy and paste.
  
  ruleset <- apriori(badboatX,                                                ## Using the apriori function on badboatX sparse Matrix to apply Association Rules Mining algorithm to obtain the rules
                     parameter = list(support = 0.005, confidence = 0.5),     ## Setting the minimum required support as 0.005 and confidence as 0.5 for each rule that is created
                     appearance = list(default = "lhs", rhs=("Survived=Yes"))) ## Filtering the rules where the right hand side is Survived = "Yes", irrespective of the LHS, i.e. picking only those rules where right hand side is survived
  
  
  ### B.	Using the inspect() command, review the "ruleset". 
  
  inspect(ruleset)
  
  ### C.	Experiment with the interactive ruleset interface by running the inspectDT() command. 
  
  inspectDT(ruleset)
  
  ### D.	In a block comment answer the following question. If you were to be onboard the titanic, what kind of person would you have wanted to be? 
  ###     Use the output of both inspect()  and inspectDT() commands to support your answer.
  
  ## Upon inspecting the rules we can observe that there are 2 rules with the highest confidence and highest lift, which means that out of all of these persons the proportion of persons who survived is very high.
  ## In this case the rules, 2nd class Child and 2nd class Female child have the highest confidence as high as 1 and the highest lift. The confidence being 1 indicates that all the 2nd class children and 2nd class female children survived.
  ## Hence if I were onboard titanic, I would prefer being a 2nd class Child or 2nd class Female Child.