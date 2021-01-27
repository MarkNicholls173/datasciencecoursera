complete <- function(directory, id = 1:332){
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where id is the monitor id number and 'nobs' is the
        ## number of complete cases
        
        ## create dataframe for results
        results <- data.frame()
        
        # for loop - each item in list
        for(file in id) {
                # open the files (pad out leading Zeros eg 001.csv)
                if(file < 10) {
                        thisFile <- (paste("00",file,".csv", sep = ""))
                }
                else if(file < 100) {
                        thisFile <- (paste("0",file,".csv", sep = ""))
                }
                else {
                        thisFile <- (paste(file,".csv", sep = ""))
                }
                
                # get data from file 
                thisDf <- read.csv(paste(directory,"/",thisFile, sep = ""))
                
                # get complete cases
                goodData <- thisDf[complete.cases(thisDf), ]
                
                # group by id - count cases
                numRows = nrow(goodData)
                
                # make dataframe of id and nobs
                thisResult <- c(file, numRows)
        
                # add to resulsts with rbind()
                results <- rbind(results, c(file, numRows))
                
        }
        # return the data frame
        names(results) <- c("id", "nobs")
        results
}

result <- data.frame()

id = 1
numRows = 120

result <- rbind(result, c(id, numRows))

names(result) <- c("id", "nobs")



df <- read.csv("./specdata/001.csv")
good <- df[complete.cases(df), ]



df2 <- read.csv("./specdata/002.csv")
good2 <- df2[complete.cases(df2), ]






files <- 1:5
directory = "specdata"
#pollutant <- "sulfate"
results <- data.frame()

for(file in files) {
        if(file < 10) {
                thisFile <- (paste("00",file,".csv", sep = ""))
        }
        else if(file < 100) {
                thisFile <- (paste("0",file,".csv", sep = ""))
        }
        else {
                thisFile <- (paste(file,".csv", sep = ""))
        }
        
        # get data from file 
        thisDf <- read.csv(paste(directory,"/",thisFile, sep = ""))
        
        # get complete cases
        goodData <- thisDf[complete.cases(thisDf), ]
        
        # group by id - count cases
        numRows = nrow(goodData)
        
        # make dataframe of id and nobs
        thisResult <- c(file, numRows)
        
        # add to resulsts with rbind()
        results <- rbind(results, c(file, numRows))
}

names(results) <- c("id", "nobs")
results
               

