# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 02
# Date due: 9th SEPTEMBER 2019
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

### PREP EXERCISE 02
### 1.
  ## a.
  myArrests <- USArrests      ### Creating Dataframe with Arrests data

### 2.
  ## a.
  View(myArrests)             ### viewing the dataframe
  
  ## b.
  attributes(myArrests)
  
  ## c.
  print.data.frame(myArrests)   ### Printing the Instances of the dataframe
  
### 3.
  ## a. 
  summary(myArrests)   ### Yields summary statistics of the dataframe
  
### 4.
  ## a.
  myFamilyNames <- c("Mom", "Dad", "Brother", "Sister")   ### Creating a Vector family names

  ## b.
  myFamilyAges <- c("48", "52" ,"9", "20")               ### Creating a vector family ages

  ## c.
  myFamilyEyeColor <-c("black", "brown", "brown", "black")  ### Creating a vector eye color
  
  ## d.
  myFamily <- data.frame(myFamilyNames, myFamilyAges, myFamilyEyeColor)  ### Merging the above 3 vectors to create a single vector

  ## e.
  str(myFamily)   ### To display the structure of the dataframe
  
  ## f.
  View(myFamily)  ### To view the dataframe

### 5.
  ## a.
  myFamily <- myFamily[-3,]     ### To remove the third row from the dataframe

  ## b.
  myFamily <- myFamily[,-3]     ### To remove the third column eye color from the dataframe
  
  ### END OF PREP EXERCISE & START OF HOMEWORK BELOW ###
  
  
### HW 02
  ### STEP A:
  summary(myArrests)       ### Viewing the summary of myArrests dataframe
  str(myArrests)
  
  ### STEP B:
  ### 1.
  ## Lower Assault Rate means lesser number of total Assaults. Hence lower assault rate is better.
  
  ### 2.
  AvgAssault <- mean(myArrests$Assault)       ### Getting Mean Assault Rate
  AvgAssault
  
  ### 3.
  lowestAssaultState <- rownames(myArrests[which.min(myArrests$Assault),])  ### State with the lowest Assault Rate
  lowestAssaultState                  ### North Dakota is the state with lowest Assault Rate
  
  ### STEP C:
    ## 1.
   highestMurderState <- rownames(myArrests[which.max(myArrests$Murder),])
  highestMurderState                          ### Georgia is the state with highest murder rate
  
  ## 2.
  sortedDF1 <- myArrests[order(myArrests$Murder,decreasing = TRUE),]
  View(sortedDF1)        ### SORTED Dataframe with descending mUrder rate

  ### 3.
  sortedTop10States <- rownames(sortedDF1[1:10,])
  sortedTop10States                                  ### 10 states with highest murder rate  
  
  ### STEP D:
   ## 1.
  #### The Murder, Assault & Rape attributes can be used to determine the safest state as these 3 are the most appropriate attributes
  
   ## 2.
  #### We can combine the 3 attributes by adding the 3 to create a single safety index score. This single safety index score can be used to determine the safest state.
  
  ## 3.
  myArrests$safeindex <- myArrests$Murder + myArrests$Assault + myArrests$Rape  ### Creating a new safeindex column
  safesates <- myArrests[order(myArrests$safeindex),]   ### Creating a new dataframe ordered by safeindex in ascending order with the safest state having the lowest safeindex score and being on the top
  safestState <- rownames(safesates[1,])    ### Picking the rowname of the state with lowest safeIndex score by picking row 1
  safestState                             ### Noth Dakota is the safest state
  
  rownames(safesates[1:5,])   ### Checking Top 5 safest states

  
  ### STEP E:
   ## 1.
    myArrests$safeindex2 <- 2*(scale(myArrests$Murder)) + scale(myArrests$Assault) + 2*(scale(myArrests$Rape))  ### Murder and Rape counting twice as much. Using scale to create new standardized safe index
    safesates2 <- myArrests[order(myArrests$safeindex2),]  ### Ordering based on new standardized safeindex 2
    safestStatesNew <- rownames(safesates2[1:5,])   ### Picking top 5 safest states and storing in a vector
    safestStatesNew     ### North Dakota, Maine, New Hampshire, Vermont and Iowa are the top 5 safest states
    
  ## 2.
    ### No, the answer in step D is not supported as the safe index is unscaled and hence it is yielding a different result.
    ### Scaling is important to ensure that the values are normalized
    