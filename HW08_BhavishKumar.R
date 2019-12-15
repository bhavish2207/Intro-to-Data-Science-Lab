# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 08
# Date due: 21st OCTOBER 2019
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

### PREP EXERCISE 08

## 1.	In a paragraph or two, explain the concept of linear modeling and its uses within data analysis.

  ### Linear Modelling is used to predict the value of a numerical variable which is called a dependent variable based on the values of other 
  ### variables which are known as the explanatory variables. A Linear equation of the form y = a+b1x1+b2x2+... 
  ### is formulated between the dependent variable whose value needs to be predicted and the explanatory variables. 
  ### The equation is formed using historical/past data for the dependent variable and the explanatory variable. 
  ### This equation is then used to predict the numeric value for the dependent variable based on the values of the explanatory variable. 
  ### The model also helps us understand how the variation in one explanatory variable impacts the value of the dependent variable. 
  ### It is very useful in data analysis and real life as with the help of linear modelling we can formulate an equation and accurately predict 
  ### the value of the dependent variable when we know the values of our explanatory variables. For example, if we need to predict the selling price of a 
  ### house based on the area in square feet, age and # beds and #baths, we can build a linear model using past data and then plug in the 
  ### available values for area in square feet, age, #beds and #baths to accurately predict the selling price of the house.

## 2.	Getting Ready: Read data from a URL directly into a data frame, the data at the end of the URL is an excel file.
   ## a.	Read in data from the following URL into a data frame
   ### http://college.cengage.com/mathematics/brase/understandable_statistics/7e/students/datasets/mlr/excel/mlr01.xls

    urlread <- "http://college.cengage.com/mathematics/brase/understandable_statistics/7e/students/datasets/mlr/excel/mlr01.xls"
    install.packages("readxl")
    library("readxl")
    df_url <- read.csv(urlread, stringsAsFactors = FALSE)     ### Reading directly from url
    View(df_url)

   ## b.	Use the 'download.file' command to download the excel spreadsheet, and store it in a temporary local file

    download.file(urlread, destfile = "webexcel.csv")   ### downloading file into directory and storing as csv

   ## c.	Use the read_excel command from the readxl package (you might need to install and library readxl). Store the data in the dataframe 'df'. 
   ##   (If you receive an error in this step related to libxls, please feel free to manually download the file from the web site and then use read_excel)
    
    df<-read_excel("webexcel.xls")  ## reading from excel into dataframe

        
  ## 3.	Examine your dataframe using the View() and str() functions.
    ### a.	Verify that there are 4 columns within your dataframe, use the following URL to identify what each column represents. 
    ###     List the column names and their respective representations below.  
    ###     http://college.cengage.com/mathematics/brase/understandable_statistics/7e/students/datasets/mlr/frames/frame.html
    
    View(df)
    str(df)
    ### The data contains 4 columns namely X1, X2, X3 and X4 where X1 is the spring fawn count/100, X2 is size of adult antelope population/100
    ### X3 is annual precipitation (inches)
    ### X4 is winter severity index (1=mild,5=severe)
    
  ## 4.	Renaming the columns within the dataframe using two methods.
    ### a.	Rename the columns within the dataframe by renaming all the columns at once. 
    ###     Purposely misspell the third column name, we will fix this later. 
    ###     If you are stuck, refer to earlier PEs and Homeworks. Place a screen shot below that shows the code that you used for this step.
    
    newcolnames <- c("spring_fawn_count_perc", "antelope_pop_perc",  "annual_precipitation", "winter_severity_index")      
    colnames(df) <- newcolnames   ### Renaming the existing column names to new more intuitive column names
    
    ### b.	Execute the View(df) command and paste a screenshot of the results below.
    
    View(df)
    
    
    ### c.	Rename the third column that was misspelled in the prior step by executing the code below. 
    ###     Explain the differences between the second approach and the first (replacing the "misspelled column name" and "correct column name" 
    ###     with the appropriate strings. What are the benefits of specifying the column name to be changed? 
                                                                                                                     
    
    colnames(df)[colnames(df)=="annual_precipitation"] <- "annual_preci"   ### Changing the incorrect column name to the correct column name which is "annual_preci"
    
    
    ### In the first approach we change all the column names at once without checking the existing column names and hence we cannot be sure if the existing names are correcct or incorrecct.
    ### In the second approach we are changing the column names of the incorrect one with the corresponding correct column name. 
    ### The benefit of the second method is that we can reduce the margin of error by specifying the condition to check if the current column name is incorrect and only then changing it to the correct name.
    ### This way we can ensure that the order in which we change the column names are correct.
    
                                                      
    ##  5.	Verify that your changes are present within the dataframe using the View command.
        ### a.	Attach a screenshot of your correctly named dataframe third column below. 
    
    View(df)  ## To ensure that the column name got corrected.
    
        
    ## 6.	Define a bivariate plot (i.e., explain what is a bivariate plot) and then explain how you would create a bivariate plot within R.
  
    ## A bivariate plot is a plot between two variables for example a scatter plot or a time series plot.
    ## Using the plot function we can create a bi variate plot in R. 
    ## We need to provide 2 vector inputs to the plot function so that it generates a plot between the 2 variables.
    
    plot(df$spring_fawn_count_perc,df$antelope_pop_perc)
        
      ## 7.	Explain the significance of the R-Squared value of a regression model.
  
    ## The R-squared value is a measure of how good or bad the model is, i.e. it tells us how much of the variation in dependent variable is explained 
    ## by the variation in independent variables. For a simple linear regression model involving only 1 independent variable, the R square value is 
    ## the square of the correlation coefficient between the 2 variables. Higher the R square the better is fit of the linear regression model and 
    ## hence better the model. Hence higher R square value is preferred. Increase in R square reduces the sum of squared errors between the actual 
    ## value and the predicted value of the dependent variable.
        
        
  ### HOMEWORK 08
    
  ## Step 1:  Visualizing a Linear Model.
    
    ## A.	Using ggplot, create a bivariate plot of the number of baby fawns versus adult antelope population. 
    ##    Make sure the Y-axis and X-axis are labeled. 
    ##    Keeping in mind that the number of fawns is the outcome (dependent) variable, which axis should it occupy in your plots? 
    ##    Comment your observations.
    
    library(ggplot2)
    qplot(antelope_pop_perc,spring_fawn_count_perc, data = df)
    
    ### Since the number of fawns is the dependent variable, we need to use that on our y axis. Hence the spring fawn count percentage was plotted on the y axis.
    
    ## B.	Using similar code, create another bivariate plot of the number of baby fawns versus precipitation that year and comment your observations.
    
    qplot(annual_preci,spring_fawn_count_perc, data = df)
    ## From this plot, we can observe that, increase in annual precipitation results in an increase in the number of baby fawns. 
    ## Hence there is a strong positive correlation between the annual precipitation and the number of baby fawns.
    
    
    ## C.	Create a final bivariate plot that examines the number of baby fawns versus severity of the winter and comment your observations.
   
    qplot(winter_severity_index,spring_fawn_count_perc, data = df)
    ## From this plot, we can observe that, increase in winter severity index results in a decrease in the number of baby fawns. 
    ## Hence there is a negative correlation between the winter severity index and the number of baby fawns.
    
    
  ## Step 2:  Creating a regression model.
   
    ##  A.	Using the above independent variables (adult antelope pop., precipitation that year, and severity of winter) create a SINGLE regression model that predicts the number of fawns.
    ##      (HINT: If you are stuck, refer to page 202 in the textbook for syntax and explanations of lm())
    
    reg_model <- lm(formula = spring_fawn_count_perc ~antelope_pop_perc + annual_preci + winter_severity_index, data = df )
    summary(reg_model)
    
    ## B.	In a comment, record the adjusted R-Squared value of the model and explain its significance to the model. 
    
    ### The adjusted R square value of the model is 0.955. It signifies that 95.5% variation in spring fawn count can be explained by 
    ###   variations in antelope population, annual precipitation and winter severity index. Adjusted R square denotes the amount of variation in dependent variable that can be explained by variations in the independent variable.
    
    ## C.	In a comment, note the predictor that is most statistically significant. 
    ##    How were you able to decide which predictors were significant and which were not?
    
    ### The predictor that is most statistically significant is annual precipation because it has the lowest p value of 0.0217 which is lower than the p values of antelope population and winter severity index.
      
      
  ## Step 3:  Interpreting the model.
    
    ## A.	Write a block comment that explains in a paragraph your overall interpretation of the model. 
    
    ### The overall interpretation can be made based on the adjusted R square value. In this model the adjusted R square is 95.5%, which is pretty high and it denotes that the model is very good. 
    ### Also the the p values of all the dependent variables fall below 0.05 and hence every dependent variable is a statistically significant predictor.
    
    ## B.	In a comment, write out the full multiple regression equation and then explain how to interpret the equation
    
    ### The full multiple regression equation will be 
    ### spring_fawn_count_perc = -5.92201 + 0.33822*antelope_pop + 0.40150*annual_preci + 0.26295*winter_severity_index
    
    ### Using the above equation we can interpret the Intercept and the coefficients of the dependent variables.
    ### Intercept interpretation: When the antelope pop, annual precipitation & winter severity index is 0, then the spring fawn count is predicted to be -5.92201 per.
    ### The coefficients of the other independent variables denote the change in the dependent variable with a unit change in the independent variable.In this case a unit increase in annual precipitation will result in 0.4015 units increase in spring fawn count.
    ### Similar interpretations can be derived for the other independent variables as well. The sign of the coefficient denotes whether the change in the dependent variable will be positive or negative with a unit increase in the independent variable.
        
     ages <- c(2,4,6,8,10)                                                                                                                                                                
ages[1]
    
ranges <- range(ages)                                                                                                                                                                     
"ranges"
ages[1]
names <- c("bro","dude","sis","dad","mom")
testdf<-data.frame(ages,names)
testdf$ages <- c(testdf$ages,12)
test<-c(2,3,5,"bro")
str(test)
