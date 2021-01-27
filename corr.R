corr <- function(directory, threshold = 0){
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of complete observed observations (on all 
        ## variables) required to compute the correlation between
        ## nitate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        ## NOTE! do not round the result!
        
        id <- 1:332
        
        ## create dataframe for results
        results <- vector("numeric")
        
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
                
                # if numrows < threshold skip
                if(numRows < threshold){ next }
                
                # calculate correlation
                thisCorr <- cor(goodData$sulfate, goodData$nitrate)
                
                # add to resulsts with rbind()
                results <-  c(results, thisCorr)
                
        }
        # return the vector
        results
}

corrresult <- data.frame()

id = 1
numRows = 120

result <- rbind(result, c(id, numRows))

names(result) <- c("id", "nobs")



df <- read.csv("./specdata/001.csv")
corgood <- df[complete.cases(df), ]



df2 <- read.csv("./specdata/002.csv")
good2 <- df2[complete.cases(df2), ]




id <- 1:5
directory <- "specdata"
threshold <- 300
results <- vector()

id <- 1:5

## create dataframe for results
results <- vector()

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
        
        # if numrows < threshold skip
        if(numRows < threshold){ next }
        
        # calculate correlation
        thisCorr <- cor(goodData$sulfate, goodData$nitrate)
        
        # add to resulsts with rbind()
        results <-  c(results, thisCorr)
        
}
# return the vector
results

id <- 1:5
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
        thisDf <- read.csv(paste(directory,"/",thisFile, sep = ""))
        goodData <- thisDf[complete.cases(thisDf), ]
        numRows = nrow(goodData)
        if(numRows < threshold){ next }
        print(numRows)
        thisCorr <- cor(goodData$sulfate, goodData$nitrate)
        results <-  c(results, thisCorr)
}

