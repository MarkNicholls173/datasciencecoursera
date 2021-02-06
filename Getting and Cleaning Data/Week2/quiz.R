# q1
# get date that jleek/datasharing report was created

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "7ae16c9534ee24a120a7",
                   secret = "2c70fde62cff69786a523e7955ea43093c8e386a"
)


# key "7ae16c9534ee24a120a7"
# secret  "2c70fde62cff69786a523e7955ea43093c8e386a"

# repo https://api.github.com/users/jtleek/repos

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)


df <- content(req)
#manually searched through till i found datasharing repo

df[[23]]$created_at


# q2
# download then read.csv the data into R object called acs

acs <- read.csv("getdata_data_ss06pid.csv")

# sqldf package allows us to use sql to query a dataframe

library(sqldf)


sqldf("select pwgtp1 from acs where AGEP < 50")


#q3 using same acs


sqldf("select distinct AGEP from acs")

#q4
## get data from url

connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)

nchar(htmlCode[c(10, 20, 30, 100)])

#q5 fixed width file



file <- read.fwf("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
                 widths = c(15, 4,9, 4,9, 4,9, 4,9))

numbers <- as.numeric(file$V4)
        
nonanumbers <- numbers[!is.na(numbers)]

sum(nonanumbers)
