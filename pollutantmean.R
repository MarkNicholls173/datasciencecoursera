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
        
        
        #for loop - each item in list
        #open the files pad out leading Zeros eg 001.csv
        #extract the column
        #stack all columns together?
        #return mean with the na flag set
        

}

df <- read.csv("./specdata/001.csv")
bad <- is.na(df$sulfate)
good <- df[!bad, ]


df2 <- read.csv("./specdata/002.csv")
good2 <-  df2[!is.na(df2$sulfate),]

mean(test$sulfate)


paste(dir,"/",0,1,".csv", sep = "")
test <- read.csv(paste(dir,"/",0,0,1,".csv", sep = ""))

