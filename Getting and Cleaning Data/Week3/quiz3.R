# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# 
# and load the data into R. The code book, describing the variable names is here:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# Create a logical vector that identifies the households on greater than 10 acres who sold more 
# than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. 
# 
# which(agricultureLogical) 
# 
# What are the first 3 values that result?
if(!file.exists("data")){dir.create("data")}
fileName <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileName, "./data/data.csv")
df <- read.csv("./data/data.csv")


library(dplyr)

tbl <- as_tibble(df)

agricultureLogical <- tbl$AGS == 6

which(agricultureLogical) # does not produce anything like the options for answers

#chose option 125, 238,262 (CORRECT)

#2
# Using the jpeg package read in the following picture of your instructor into R
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting 
# data? (some Linux systems may produce an answer 638 different for the 30th quantile)

if(!file.exists("data")){dir.create("data")}
fileName = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileName, "./data/q2.jpg")


library(jpeg)
img <- readJPEG("./data/q2.jpg", native = TRUE)

quantile(img, c(0.3, 0.8)) #  produces nothing like the selection of answers

# attempt 1 chose -16776430 -15390165 (WRONG)
# attempt 2 chose -10904118 -10575416 (WRONG)

#q3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# 
# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?
#         
#         Original data sources: 
#         
#         http://data.worldbank.org/data-catalog/GDP-ranking-table
# 
# http://data.worldbank.org/data-catalog/ed-stats

if(!file.exists("data")){dir.create("data")}
fileName <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileName, "./data/q3a.csv")
dom_prod <- read.csv("./data/q3a.csv", skip = 4)

names(dom_prod) <- c("CountryCode", "rank", "col3", "Name", "col6", "col7 ","col8 ","col9","col10", "col11" )


fileName <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv" 
download.file(fileName, "./data/q3b.csv")
education <- read.csv("./data/q3b.csv")

merged_data <- merge(dom_prod, education)

merge_tib <- as_tibble(merged_data)

filter(merge_tib, rank != "") %>%
        print

# A tibble: 189 x 40
merge_tib_sorted <- merge_tib %>%
        mutate(rank = as.numeric(rank)) %>%
        arrange(desc(rank) )
merge_tib_sorted[13, "Name"]    

# 1 St. Kitts and Nevis    

# 189 matches, 13th is St Kitts...

#q4
#What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?  

merge_tib %>%
        mutate(rank = as.numeric(rank)) %>%
        group_by(Income.Group) %>%
        filter(!is.na(rank)) %>%
        summarise(ave_GPD_rank = mean(rank)) %>%
        print

# # A tibble: 5 x 2
# Income.Group         ave_GPD_rank
# <chr>                       <dbl>
#         1 High income: nonOECD         91.9
# 2 High income: OECD            33.0
# 3 Low income                  134. 
# 4 Lower middle income         108. 
# 5 Upper middle income          92.1

# answer is 32.96667, 91.91304

# q5 Question 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?

merge_tib <- mutate(merge_tib, rank = as.numeric(rank))

# save quantiles in a vector
qnt <- quantile(merge_tib$rank, probs = seq(0, 1, 0.2), na.rm=TRUE)
quant_tib <- merge_tib %>%
        select(CountryCode, rank, Income.Group) %>%
        mutate(quantile = cut(rank, qnt))

table(quant_tib$Income.Group, quant_tib$quantile)

#                       (1,38.6] (38.6,76.2] (76.2,114] (114,152] (152,190]
#                             0           0          0         0         0
# High income: nonOECD        4           5          8         4         2
# High income: OECD          17          10          1         1         0
# Low income                  0           1          9        16        11
# Lower middle income         5          13         11         9        16
# Upper middle income        11           9          8         8         9

#answer is 5

