pollutantmean <- function(directory, pollutant, id = 1:332){
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either sulfate or nitrate
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all the monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result
        
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
                
                # column (filter NAs)
                goodData <-  thisDf[!is.na(thisDf[pollutant]),][pollutant]
                
        
                # add to resulsts with rbind()
                results <- rbind(results, goodData)
                
        }
        # return mean with the na flag set
        mean(results[,1])
}

df <- read.csv("./specdata/001.csv")
bad <- is.na(df$sulfate)
good <- df[!bad, ]

pollutant <- "sulfate"
df2 <- read.csv("./specdata/002.csv")
column <- df2[pollutant]

goodData <-  df2[!is.na(df2[pollutant]),][pollutant]

mean(test$sulfate)


paste(dir,"/",0,1,".csv", sep = "")
test <- read.csv(paste(dir,"/",0,0,1,".csv", sep = ""))

rbind(good, good2)

files <- 1:5
directory = "specdata"
pollutant <- "sulfate"
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
        thisDf <- read.csv(paste(directory,"/",thisFile, sep = ""))
        ## filter out NA before adding to results
        goodData <-  thisDf[!is.na(thisDf[pollutant]),][pollutant]
        
        
        
        results <- rbind(results, goodData)
}

mean(results[,1])
               

