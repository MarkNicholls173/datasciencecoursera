library(tidyr)
library(dplyr)

if(!file.exists("data")){dir.create("data")}

# 
# Question 1
# The American Community Survey distributes downloadable data about United 
# States communities. Download the 2006 microdata survey about housing for
# the state of Idaho using download.file() from here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# 
# and load the data into R. The code book, describing the variable names is here:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list


if(!file.exists("data")){dir.create("data")}
fileURl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURl, "./data/q1_data.csv")
df <- read.csv("./data/q1_data.csv")

#the question wording confused me.... names of the df means column names
strsplit(names(df), "wgtp")[123]
# 
# [[1]]
# answer is
# [1] ""   "15"




# 
# Question 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
#         
#         Original data sources:
#         
#         http://data.worldbank.org/data-catalog/GDP-ranking-table


fileURl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURl, "./data/q2_data.csv")
df2 <- read.csv("./data/q2_data.csv", skip = 4, nrows = 190)
names(df2) <- c("code", "rank", "3", "name", "gdp", "6", "7", "8", "9", "10")

#look at the df
str(df2)

# 'data.frame':	326 obs. of  10 variables:
#         $ code: chr  "USA" "CHN" "JPN" "DEU" ...
# $ rank: chr  "1" "2" "3" "4" ...
# $ 3   : logi  NA NA NA NA NA NA ...
# $ name: chr  "United States" "China" "Japan" "Germany" ...
# $ gdp : chr  " 16,244,600 " " 8,227,103 " " 5,959,718 " " 3,428,131 " ...
# $ 6   : chr  "" "" "" "" ...
# $ 7   : logi  NA NA NA NA NA NA ...
# $ 8   : logi  NA NA NA NA NA NA ...
# $ 9   : logi  NA NA NA NA NA NA ...
# $ 10  : logi  NA NA NA NA NA NA ...

#gdp is chr

#replace comma with "" using sub
df2$gdp <- gsub(",", "", df2$gdp) # sub only did first match changed to gsub

# convert to numeric before checking for na
df2$gdp <- as.numeric(df2$gdp)

#check for NA
sum(is.na(df2$gdp))
#[1] 122

#subset for not NA
df2_nona <- df2[!is.na(df2$gdp), ]

#mean of
mean(df2_nona$gdp)

# answer [1] 377652.4

## WHAT I WAS MISSING
## assumed just needed to skip the first 4 rows
## i had not explored the tail to see rows at the bottom that were affecting the output

# Question 3
# In the data set from Question 2 what is a regular expression that would 
# allow you to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United? 

#1 grep("*United",countryNames), 2

#1 grep("United$",countryNames), 3

#3 grep("*United",countryNames), 5

#4 grep("^United",countryNames), 3

#4 as that the one with teh caret ^ that says the pattern should appear at the start


# Question 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# 
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?
#         
#         Original data sources: 
#         
#         http://data.worldbank.org/data-catalog/GDP-ranking-table
# 
#         http://data.worldbank.org/data-catalog/ed-stats

#first data already downloaded above
gdp_data <- read.csv("./data/q2_data.csv", skip = 4, nrows = 190)
names(gdp_data) <- c("CountryCode", "rank", "3", "name", "gdp", "6", "7", "8", "9", "10")

#download load second data
eduURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(eduURL, "./data/q3_edu_data.csv")
edu_data <-  read.csv("./data/q3_edu_data.csv")

#look at str, head and tail of edu data
str(edu_data)
head(edu_data)
tail(edu_data)


# 'data.frame':	234 obs. of  31 variables:
# $ CountryCode                                      : chr  "ABW" "ADO" "AFG" "AGO" ...
# $ Long.Name                                        : chr  "Aruba" "Principality of Andorra" "Islamic State of Afghanistan" "People's Republic of Angola" ...
# $ Income.Group                                     : chr  "High income: nonOECD" "High income: nonOECD" "Low income" "Lower middle income" ...
# $ Region                                           : chr  "Latin America & Caribbean" "Europe & Central Asia" "South Asia" "Sub-Saharan Africa" ...
# $ Lending.category                                 : chr  "" "" "IDA" "IDA" ...
# $ Other.groups                                     : chr  "" "" "HIPC" "" ...
# $ Currency.Unit                                    : chr  "Aruban florin" "Euro" "Afghan afghani" "Angolan kwanza" ...
# $ Latest.population.census                         : chr  "2000" "Register based" "1979" "1970" ...
# $ Latest.household.survey                          : chr  "" "" "MICS, 2003" "MICS, 2001, MIS, 2006/07" ...
# $ Special.Notes                                    : chr  "" "" "Fiscal year end: March 20; reporting period for national accounts data: FY." "" ...
# $ National.accounts.base.year                      : chr  "1995" "" "2002/2003" "1997" ...
# $ National.accounts.reference.year                 : int  NA NA NA NA 1996 NA NA 1996 NA NA ...
# $ System.of.National.Accounts                      : int  NA NA NA NA 1993 NA 1993 1993 NA NA ...
# $ SNA.price.valuation                              : chr  "" "" "VAB" "VAP" ...
# $ Alternative.conversion.factor                    : chr  "" "" "" "1991-96" ...
# $ PPP.survey.year                                  : int  NA NA NA 2005 2005 NA 2005 2005 NA NA ...
# $ Balance.of.Payments.Manual.in.use                : chr  "" "" "" "BPM5" ...
# $ External.debt.Reporting.status                   : chr  "" "" "Actual" "Actual" ...
# $ System.of.trade                                  : chr  "Special" "General" "General" "Special" ...
# $ Government.Accounting.concept                    : chr  "" "" "Consolidated" "" ...
# $ IMF.data.dissemination.standard                  : chr  "" "" "GDDS" "GDDS" ...
# $ Source.of.most.recent.Income.and.expenditure.data: chr  "" "" "" "IHS, 2000" ...
# $ Vital.registration.complete                      : chr  "" "Yes" "" "" ...
# $ Latest.agricultural.census                       : chr  "" "" "" "1964-65" ...
# $ Latest.industrial.data                           : int  NA NA NA NA 2005 NA 2001 NA NA NA ...
# $ Latest.trade.data                                : int  2008 2006 2008 1991 2008 2008 2008 2008 NA 2007 ...
# $ Latest.water.withdrawal.data                     : int  NA NA 2000 2000 2000 2005 2000 2000 NA 1990 ...
# $ X2.alpha.code                                    : chr  "AW" "AD" "AF" "AO" ...
# $ WB.2.code                                        : chr  "AW" "AD" "AF" "AO" ...
# $ Table.Name                                       : chr  "Aruba" "Andorra" "Afghanistan" "Angola" ...
# $ Short.Name                                       : chr  "Aruba" "Andorra" "Afghanistan" "Angola" ...

#fiscal year end appers to be in special notes column e.g.
edu_data[11, "Special.Notes"]
#[1] "Fiscal year end: June 30; reporting period for national accounts data: FY."
# grep pattern to match is "^Fiscal year end: June"
grep("^Fiscal year end: June", edu_data$Special.Notes)
# [1]  11  18  31  60  76 105 112 166 173 188 199 216 234

# merge/match data 
# changed the col title for code to be CountryCode as merge defaults to cols with same name
merge_data <- merge(gdp_data, edu_data)

#look at data str/head/tail
#all look good ... 189 matches i think same as previous weeks question

length(grep("^Fiscal year end: June", merge_data$Special.Notes))
# answer [1] 13

# Question 5
# You can use the quantmod (http://www.quantmod.com/) package to get 
# historical stock prices for publicly traded companies on the NASDAQ 
# and NYSE. Use the following code to download data on Amazon's stock
# price and get the times the data was sampled.
# 

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# sample looks to be a vector of dates
str(sampleTimes)

# Date[1:3552], format: "2007-01-03" "2007-01-04" "2007-01-05" "2007-01-08" "2007-01-09" ...

library(lubridate)

# q5a how many values were collected in 2012
y2012 <- year(sampleTimes) == 2012
sum(y2012)
#[1] 250

#or in one line
sum(year(sampleTimes) == 2012)


# q5b how many values were collected on mondays in 2012
sum(year(sampleTimes) == 2012 & wday(sampleTimes, label = T) == "Mon")
#[1] 47

#answer 250, 47
