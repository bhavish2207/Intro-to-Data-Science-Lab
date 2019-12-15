# IST 687
#
# Student name: BHAVISH KUMAR
# Homework number: 11
# Date due: 18th NOVEMBER 2019
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

### PREP EXERCISE 11
## 1.	Getting Ready: Loading the data.
  ## a.	Install the "tm" package and library it. 

install.packages("tm")
library(tm)

  ## b.	On Blackboard download the speech.txt, positive-words.txt, and negative-words.txt files. Set the working directory to point to the folder that contains the downloaded files.

## Downloaded the files and saved them in my working directory. "C:\\Users\\LENOVO\\Desktop\\SYR ADS\\Sem 1\\IST 687 Intro to Data Science\\Prep Exercise & Homework"

  ## c.	 Read in the speech.txt file using the scan() function, the code is provided below. 

    charVector <- scan("speech.txt", character(0), sep = "\n")          ## Saving speech text file to vector

  ## d.	Using similar code read in the positive-words.txt and negative-words.txt files as "posWords" and "negWords" respectively.  
  ##    Be sure to remove any header information from those files (if you need help, review chapter 15 in the text book).
    
    posWords <- scan("positive-words.txt", character(0), sep = "\n")     ## Saving positive words text file to vector. The \n seperator ensure line by line reading & character(0) tells scan that we are reading characters.
    posWords <- posWords[-1:-34]                                         ## Removing first 34 rows 
    negWords <- scan("negative-words.txt", character(0), sep = "\n")     ## Saving Negative words text file to vector
    negWords <- negWords[-1:-34]                                         ## Removing first 34 rows from vector
    
        
## 2.	Condition the text file. 
## a.	Examine charVector using the head() and summary() commands.
    
    head(charVector)
    summary(charVector)
    
## b.	Describe the items returned from the previous step and place a screenshot of each command's output below 
##    (hint: There should be 166 total items in the charVector)
    
    ## The head function returns the first 6 rows of the vector where each row contains one whole sentence from the text file. Since the sepearator is \n we will store line by line.
    
    ## The summary function tells us the number of rows in the vector, the class and the datatype/mode.


## 3.	Transform charVector into a term document matrix.
  ## a.	In a few sentences define/explain a term document matrix.

    ## A Term Document Matrix is used to convert the loaded text vector into a rectangular matrix data structure with rows and columns where the 
    ##   rows appear as terms and documents appear as columns. If a term "analyst" appears once in document 1 and thrice in documents 2, then the columns for term "analyst" will contain 1, 3.
    
  ## b.	Create a word corpus (called words.corpus). Then, make sure everyting is lower case, remove punctuation, remove numbers and then, finally, 
  ##    remove English stopwords. If you need help, review pages 180-181 in the text book (Note: Ignore any warning messages that come from tm_map())
    
    words.vec <- VectorSource(charVector)
    words.corpus <- Corpus(words.vec)
    words.corpus <- tm_map(words.corpus, content_transformer(tolower))     ## Making all the letters lower case
    words.corpus <- tm_map(words.corpus, removePunctuation)             ## Removing all the punctuations
    words.corpus <- tm_map(words.corpus, removeNumbers)                 ## Removing all the numbers
    words.corpus <- tm_map(words.corpus, removeWords, stopwords("english"))   ## Removing all the stop words such as 'the', 'a', 'an', 'at' etc. which are useless for differentiating  between the documents 
        
  ## c.	Create a TermDoumentMatrix variable called 'tdm', from the words.corpus variable.

    tdm <- TermDocumentMatrix(words.corpus)     ## Creating a Term Document Matrix from the words.corpus using the function
    
## 4.	Understanding the term document matrix.
  ## a.	Using inspect(tdm) function create a summary of the term document matrix along with a sample of some of the terms and documents.
    
    inspect(tdm)   ## Using the inspect() function to view the summary of the term document matrix
      
  ## b.	In a few sentences, explain the output from the previous step. Place a screenshot of the output from inspect(tdm) below.
    
    ## In the previous step we obtained a summary of our term document matrix using the inspect function. 
    ## From the summary we can observe that the function has created 1211 terms and 166 documents becasue of which our matrix will have 1211 rows and 166 columns.
    ## The Non Sparse entries parameter shows us that out of 198452 cells in the matrix (1211 rows and 166 columns) there are only 2574 cells with non zero entries.
    ## The weighting parameter shows that we use the term frequency in each cell, i.e. it indicates the number of occurences of a given term across each document.
    ## We also get to see a small sample of some of the terms and their documents.
    
                ### HOMEWORK 11 ###
    
 ## Step 1:  Create a list of word counts from the speech.
    ## A.	Create a named list of word counts by frequency, then sort as shown below:
    
    mat <- as.matrix(tdm)    ## Converts the term document matrix into something like a word document matrix with individual words on the rows on their occurences in each document denoted by a 1/0 flag under the document.
    wordCounts <- rowSums(mat)  ## Taking sum along the rows to get the count of occurences of each word
    wordCounts <- sort(wordCounts, decreasing=TRUE)      ## Sorting it in decreasing order of occurences of words.
    View(wordCounts)
    
    ## B.	Run the head(wordCounts) command and explain what you see in a block comment. 
    
    head(wordCounts)
    ## We see the top 6 most frequently occuring words using the head() function, as it has been sorted in decreasing order of occurences of words.
    
    ## C.	In a block comment, state how many unique words there are in the speech and what R code did you use to determine this answer?
    
    
    wordcloud_df <-data.frame(word = names(wordCounts),freq = wordCounts)
    length(unique(wordcloud_df$word))
    ## There are 1211 unique words in the speech. I obtained this by converting the matrix into a dataframe with columns word and freq which denote the words occuring in the document and their frequency respectively.
    ## Then by applying the length() and unique() functions on the word column as shown in the above code, we can obtain the number of unique words in the speech.  
    
     ## D.	In a block comment, state how many total words there are in the speech and what R code did you use to determine this answer?
     
    sum(wordcloud_df$freq) 
    ## There are a total of 2762 words in the speech. I determined this answer by applying the sum() function as shown above on the freq column. 
    ## The freq column denotes the number of occurences of each word in the speech and by taking the sum of that column, we will get the total number of words in the speech.
      
 ## Step 2:  Match the speech words with positive and negative words. 
    
     ## A.	Using the code provided below match the words from the speech to the list of positive words.
   
      matchedP <- match(names(wordCounts), posWords, nomatch = 0) 
       ## Using the match() function to match all the words of the speech with the positive words.
       ## This returns the position at which each of the 1211 distinct words have matched with the positive words. A 0 denotes that the corresponding word did not occur in the positive words list.
       ## A 200 denotes that the corresponding word is occuring at 200th position in the posWords vector.
      
    ## B.	Create a similar line of code to match the speech to the negative words. In a block comment explain the code that you wrote. 
      matchedN <- match(names(wordCounts), negWords, nomatch = 0)
         ## Using the match() function to match all the words of the speech with the negative words. 
         ## Matching the negwords vector with the words of the speech. The names() function produces a vector containing all the distinct words in the speech.
      
    ## C.	Write a block comment that described the information that "matchedP" contains. How long is that vector? 
    ##     What do the numeric values in it represent?
      
      ## The match function retrns a vector with the positions of matches of the first argument with the second argument. Here matchedP is a vector.
      ## The "matchedP" vector contains 1211 rows for each of the 1211 distinct words in the speech and the number at each row denotes the position at which the corresponding word occurs in the "posWords" vector and a 0 denotes that the word is not present in the "posWords" vector.
      ## For example if row 61 contains the number 200, it means that the word present at 61st position in the "wordCounts matrix" is present at 200th position in the "posWords" vector.
      
      
 ## Step 3:  Making bar charts of the words that matched.
    
      ## A.	Using ggplot, make a bar chart of the positive matches.
      
      library(ggplot2)
      matchedPoswords <- wordcloud_df[which(matchedP != 0),]    ## Creating a dataframe of the matched positive words and their frequencies
      
      bargraph_matchP <- ggplot(data = matchedPoswords, aes(x=matchedPoswords$word, y = matchedPoswords$freq)) + 
        geom_col() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        ggtitle("Matched Positive Words of speech")
      bargraph_matchP
       
     ## B.	Using ggplot,  create a bar chart of the top 20 negative matches. 
      
      matchedNegwords <- wordcloud_df[which(matchedN != 0),]    ## Creating a dataframe of the matched negative words and their frequencies
      matchedNegwords_sort20 <- head(matchedNegwords[order(matchedNegwords$freq, decreasing = TRUE),],20)
      
      bargraph_matchN <- ggplot(data = matchedNegwords_sort20, aes(x=matchedNegwords_sort20$word, y = matchedNegwords_sort20$freq)) + 
        geom_col() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        ggtitle("Top 20 Matched Negative Words of speech")
      bargraph_matchN
    
     ## C.	Create two additional bar charts that only shows the negative, and positive words, that occurred at least twice.
      
      matchedPoswords_twice <- matchedPoswords[matchedPoswords$freq>1,]      ### Filtering out rows with frequency greater than 1 (occuring twice)
      bargraph_matchP_twice <- ggplot(data = matchedPoswords_twice, aes(x=matchedPoswords_twice$word, y = matchedPoswords_twice$freq)) + 
        geom_col() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        ggtitle("Positive Words occured atleast twice")
      bargraph_matchP_twice
      
      
      matchedNegwords_twice <- matchedNegwords[matchedNegwords$freq>1,]
      bargraph_matchN_twice <- ggplot(data = matchedNegwords_twice, aes(x=matchedNegwords_twice$word, y = matchedNegwords_twice$freq)) + 
        geom_col() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        ggtitle("Negative Words occured atleast twice")
      bargraph_matchN_twice
      
    
     ## D.	Calculate the ratio that shows the proportion of positive words relative to the total number of words in the speech. 
     ##     Do the same for negative words. In a comment, explain if the speech was a positive or negative speech.
      
      ratio_pos_words <- sum(matchedPoswords$freq)/sum(wordcloud_df$freq)
      ratio_pos_words     ## The ratio for positive words is 7.82%, i.e. out of the total number of words in the speech, 7.82% of them are positive.
      
      
      ratio_neg_words <- sum(matchedNegwords$freq)/sum(wordcloud_df$freq)
      ratio_neg_words     ## The ratio for negative words is 3.91%, i.e out of the total number of words in the speech, 3.91% of them are negative.
      
      ## Since the ratio of positive words is double of the ratio of negative words, i.e. there are twice as many total positive words in the speech than the negative words.
      ## Hence the speech was a positive speech. There are a total of 216 positive words and a total of 108 negative words.
    