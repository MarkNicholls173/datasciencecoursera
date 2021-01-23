#Question 11
#Use the Week 1 Quiz Data Set to answer questions 11-20.

#In the dataset provided for this Quiz, what are the column names of the dataset? 

#load data
data <- read.csv("./quiz1_data/hw1_data.csv")

#view head
head(data)


#Question 12
#Extract the first 2 rows of the data frame and print them to the console. What does the output look like?
  
head(data, 2)


#Question 13
#How many observations (i.e. rows) are in this data frame?

data #look at last row number
#i suspect there will be a better way to get this in the future


#Question 14
#Extract the last 2 rows of the data frame and print them to the console. What does the output look like?

tail(data, 2)

#Question 15
#What is the value of Ozone in the 47th row?

data[47,"Ozone"]

#Question 16
#How many missing values are in the Ozone column of this data frame?

#create logical vector of  rows where Ozone is Na
missing <- data[is.na("Ozone")]

#sum logical vector (auto coerce to numerical true = 1)
sum(missing)

#Question 17
#What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.

#create vector of Ozone values
Ozone <- data$Ozone

#mean of Ozone values removing missing row
mean(Ozone[!missing])

#Question 18
#Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?

#logical vector of rows with only complete data
good <- complete.cases(data)

#subset of data without any Nas
data_nona <- data[good, ]


# mean function, with filters for Ozone and Temp, extract the Solar.R column
mean(data_nona[data_nona$Ozone > 31 & data_nona$Temp > 90, ]$Solar.R)

#Question 19
#What is the mean of "Temp" when "Month" is equal to 6? 

mean(data[data$Month == 6, ]$Temp)


#Question 20
#What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?

max(data_nona[data_nona$Month == 5, ]$Ozone)

