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

### PREP EXERCISE 07

## 1.	Getting Ready: Load and repair median income data
    ### A.	Download the provided MedianZIP.csv file from Blackboard and read into R-studio into a dataframe called "mydata". 
    ###     HINT: Use read_csv() to simplify later steps!

      mydata <- read.csv("MedianZIP.csv", stringsAsFactors = FALSE)    ### Reading MedianZIP csv into mydata dataframe
      mydata$Mean <- as.numeric(mydata$Mean)                          ### Converting Mean column to numeric values
  
    ### B.	Cleaning up the NAs: Find and fix the missing data in the Mean column by substituting the value from the Median column 
    ###     in place of the missing mean values. Explain why the median is a reasonable replacement for the mean.
      
      which(is.na(mydata$Mean))                                                  ### Obtaining row indexes of rows containing NA values in Mean column
      mydata$Mean[is.na(mydata$Mean)] <- mydata$Median[is.na(mydata$Mean)]       ### Substituting the NAs with corresponding value from Median column
      
      ### Median is a reasonable replacement for the mean value because median is a good measure of central tendency and moreover median is not affected by outliers or skewness in the data.
      ### Hence since Mean is not available the best possible replacement is median.
    
    ### C.	Examine the data with View( ) and add comments explaining what each column contains. 
    ###     Add a comment explaining why the first 2391 zip codes look weird. 
      
      View(mydata)
      str(mydata)
      
      ### The data contains 5 columns which are zip, Median, Mean & Pop that contains the zipcode of the place, the Median income of the location, the Mean income of the location and the population of the location respectively.
      
      ## The first 2391 zip codes look weird becuase the zip codes contain values of integer data type and also they contain only 4 digits,
      ## whereas ideally a zipcode should contain 5 digits as that is the appropriate zip code format.

## 2.	Merge the median income data with detailed zipcode data
    ### A.	Code and execute the commands below. Write a paragraph below that explains what this code does.

        install.packages("zipcode")
        library(zipcode)
        mydata$zip <- clean.zipcodes(mydata$zip)
        View(mydata)
        data(zipcode)
        dfNew <- merge(mydata, zipcode, by="zip")
        
        ### The above code installs the zipcode package at first and uses the clean.zipcodes() function to get all the values in the zip column of mydata
        ### dataframe to the coorect zipcode format of 5 digits and also converts the datatype to character. It restores leading zeroes to all the zipcodes that have only 4 digits.
        ### The data() function loads in built datasets. The inbuilt zipcode dataset is being used.
        ### A new dataframe is obtained by merging the mydata dataframe and zipcode dataframe on the zip column
        
## 3.	Merge the new dataset with stateNameDF data
   ### A.	Create a new dataframe with the following code:
  
        stateNameDF <- data.frame(state=state.abb, stateName=state.name, center=state.center)
        stateNameDF$stateName <- tolower(stateNameDF$stateName)

   ### B.	Comment each line of the code to explain what it is doing

        ### 1. Creating a new stateNameDF using the data.frame function and including the vectors state, stateName & center. 
        ###    The state vector gets its values from the abb(abbreviation) column of the inbuilt dataset state. Likewise the vectors stateName and center also get their values from state.name and state.center respectively.
        
        ### 2. The values in stateName column are reduced to lowercase using the tolower() function.
        
   ### C.	Using steps similar to step 2 create a new dataframe that contains our previous information and the information from the stateNameDF.  
        
       new_df <- merge(dfNew, stateNameDF, by = "state")   ### Merging the dfNew dataset and stateNameDF on state column to obtain all the columns.
       
        
## 4.	Examine your new df with the View command. 
   ### A.	Include a screen shot of the first 10 rows of data and all of your columns.
       View(new_df)
       
          
       ### HOMEWORK 07
       ## STEP 1: Plot points for each zipcode (don't forget to library ggplot2 and ggmap)
          ### A.	Code and execute the following lines of code
       
       library(ggplot2)
       install.packages("ggmap")
       library(ggmap)
       install.packages("maps")
       library(maps)
       library(tidyverse)
       us <- map_data("state")   ## The map_data function is used to obtain the data from the maps package and load it into a dataframe. A new dataframe called us is created.
       dotmap<- ggplot(new_df, aes(map_id = stateName))          ## A new variable called dotmap is created using the ggplot function and the new_df dataframe created in the prep exercise is being used as data source. The aesthetics are defined and stateName is assigned to map_id
       dotmap<- dotmap + geom_map(map = us)                     ## geom_map function is used to obtain a map and us dataframe is passed to the map
       dotmap<- dotmap + geom_point(aes(x=longitude,y=latitude,color=Mean))   ## The geom_point function is used to assign longitude & latitude and display the mean for these coordinates as dots and display it.
       dotmap
       
        ### B.	Comment each line of code explaining what it does
       
       ## The map_data function is used to obtain the data from the maps package and load it into a dataframe. A new dataframe called us is created.
       ## A new variable called dotmap is created using the ggplot function and the new_df dataframe created in the prep exercise is being used as data source.
       ## The aesthetics are defined and stateName is assigned to map_id
       ## geom_map function is used to obtain a map and us dataframe is passed to the map
       ## The geom_point function is used to assign longitude & latitude and display the mean for these coordinates as dots.
       
        ### C.	Add a block comment that criticizes the resulting map. It's not very good (but you need to explain why it is not very good).
       
       ### The map is not very good because of the color scale being used, making it difficult to differentiate between the colors. 
       ### Moreover, the map shows very little information as the there is no clear boundary seggregating the various zipcodes and hence it is very hard to tell what is the mean income level for each zipcode.
       ### Also there are certain points outside the geographical boundary of US in the ocean and we have no information about what these points represent.
       
       
       ## Step 2:  Use Tidyverse to create a Data Frame of State-by-State Income
        ### A.	Library the tidyverse() package (if you have not already done so), and then run the following command to create a new data frame:
       
         summaryDF <- new_df %>%
         group_by(stateName) %>%
         summarize(totalPop=sum(Pop), Income=sum(Mean*Pop))
      
        ### B.	Add a comment after each line, describing what each line of code does. Make sure to describe how many rows there are in the new dataframe, 
        ###     and how the new dataframe was created.
       
         ## The above code creates a new dataframe called summaryDF using the state dataframe and then groups by state to obtain Population and total Income for each state.
         ## The new dataframe will have 50 rows as we are grouping by state and rolling up the data to state level. Hence 1 row for each state.
         
        ### C.	Create a new variable on this data frame called meanIncome. Divide Income by totalPop to find the average income for each state.
         
       summaryDF$meanIncome <- summaryDF$Income/summaryDF$totalPop      ### Dividing total Income column by total Population column to obtain mean Income column.
         
       ## Step 3:  Create a map of the U.S. showing average income
       
         ### A.	Create a map visualization, where the color of each state represents the mean income for that state.
        #install.packages("mapproj") 
       library(mapproj)
       statemap<- ggplot(summaryDF, aes(map_id = stateName))                   ### Creating a new variable called statemap for ggplot and using summaryDF as data source. Assigning stateName as map_id.                                           
       statemap<- statemap + geom_map(map = us,aes(fill=meanIncome))           ### Using geom_map function to create a map with us states data and filling each state with a color to represent the mean income for that state.
       statemap<- statemap + expand_limits(x= us$long, y = us$lat)             ### We then expand the limits for the map based on longitude and latitude for US states.
       statemap<- statemap + coord_map()                                       ### coord_map() ensures that the map has the right proportions and it is not distorted or stretched
       statemap<- statemap + ggtitle("state map")                              ### We add a title to the visualization
       statemap
         
       ### B.	If you need help creating the map, review Chapter 13, and how Figure 13.2 was created.
         
         
         ### C.	You will notice some states are grey. In a block comment explain why they are grey
       
       ## None of the states are in grey here because there are no missing values for income at state level, i.e. all the NAs have been treated in the prep exercise by replacing the NAs with the median at zipcode level.
       ## This NA treated dataset has been used for grouping by at state level and hence all the states have their corresponding meanIncome value present and there are no missing values. Hence there are no grey states in the map visualization.
         
         ### D.	Fix this issue so that all states have an appropriate shade of blue - i.e.,  
         ###    generate the map visualization, where the color of each state represents the mean income for that state without any state being grey 
         ###    (hint: look if there are NAs).
       
       ## The NAs have been treated and the required visualization with all the states having an appropriate shade of blue has been generated in Step A itself.
       
       ## Step 4:  Show the population of each state on the map
       
         ### A.	Use the stateNameDF (that was created and used in the prework) and merge that dataframe with the summaryDF dataframe, so that the center.x and center.y information is merged with the summaryDF dataframe information in your new dataframe.
       
       state_summary <- merge(stateNameDF, summaryDF, by = "stateName")    ## Merging the 2 dataframes on stateName column to create a resultant dataframe containing statename, income, pop & xy coordinates of center
         
         ### B.	Create a new map visualization, which is the same visualization created in step 3, but now add a new layer, 
         ###    with a point, at the center of each state, where the point size represents the total population of that state.
       
       statemap_new<- ggplot(state_summary, aes(map_id = stateName))       ### Creating a new variable called statemap_new for ggplot and using state_summary as data source. Assigning stateName as map_id.                                                         
       statemap_new<- statemap_new + geom_map(map = us,aes(fill=meanIncome)) + geom_point(aes(x=center.x,y=center.y,size=totalPop))  ### Using geom_map function to create a map with us states data and filling each state with a color to represent the mean income for that state. Also using geom_point to add a point at the center of each state where the size of the point represents the state population.
       statemap_new<- statemap_new + expand_limits(x= us$long, y = us$lat)  ### We then expand the limits for the map based on longitude and latitude for US states.
       statemap_new<- statemap_new + coord_map()+ggtitle("state map")                  ### We add a title to the visualization. coord_map() ensures that the map has the right proportions and it is not distorted or stretched
       statemap_new  
       
         ### C.	If you need a hint on how to do this visualization, you need to have a center.x and center.y in your summaryDF 
         ###    (i.e., you need to create a new summaryDF with center.x and center.y).
       
       ## Used the dataframe that was created in step A by merging the stateNameDF & summaryDF
       
       
       
       dftree<-createDataPartition(df, p=.5,list=FALSE)
y<-c(1,5,4,8,9,3)
x<-c('A','b','c','a','b','c')
qhub = data.frame(y,x)       
lm(y~x,data = qhub)

subset(df,!duplicated(x))


t = as.data.frame(df)
df.qty