## notes
##check if directory exists and create one if not
if(!file.exists("data")){dir.create("data")}

## q1 & 2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "data.csv")
df = read.csv("data.csv")
mydf <- df[df$VAL == 24, ]
noNa <- df[!is.na(df$VAL),]
my24 = noNa[noNa$VAL == 24,]


#q3
##unable to use package: xlsx
##using readxl instead
##use the range argument to import a specific range
##getting unzip error so added mode = WB argument to download
library(readxl)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "q2.xlsx", mode = "wb")
dat <- read_xlsx("q2.xlsx", range = "R18C7:R23C15")
##run this
sum(dat$Zip*dat$Ext,na.rm=T)

#q4
## 
## 
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xmlDoc <- xmlTreeParse(fileUrl, useInternalNodes = T)
rootNode <- xmlRoot(xmlDoc)
## spent ages on this as i missed is was xpathSApply and was trying to use xmlSApply
results <- xpathSApply(rootNode, "//zipcode", xmlValue)
sum(results == "21231")

#q5
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "table.csv")
DT <- fread("table.csv")


#change made in issue01 branch
