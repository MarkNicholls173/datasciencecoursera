rankall <- function(outcome, num = "best"){
        ## state:       character abbrevation for state
        ## num:          ranking of hospital in that outcome (best|worse or int rank)
        ##
        ## return 2 columns dataframe containing 1 row for each state
        ##     Hospital Name | state
        ##
        ## return NA if if no rank exists in that state
        ##
        ## columns of interest
        ## [2] Hospital.Name
        ## [7] State
        ## [11] heart attack mortality
        ## [17] heart failure mortality
        ## [23] pnuemonia mortality
        ##
        ## validate inputs state is valid and outcome is one of the 3
        ## stop "invalid state|outcome/num"
        ##
        
        ##read outcome data
        allOutcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## get distinct list of states
        states = sort(unique(allOutcomeData[,7]))
        
        ## set outcome column and test for invalid outcome
        if(outcome == "heart attack"){
                outcomeCol <-  11
        } else if(outcome == "heart failure"){
                outcomeCol <- 17
        } else if(outcome == "pneumonia") {
                outcomeCol <- 23
        } else {
                stop("invalid outcome")
        }
        
        
        
        ##set outcome to numeric
        allOutcomeData[, outcomeCol] <- as.numeric(allOutcomeData[,outcomeCol])
        
        ##subset for not NA, get name, state and outcome
        myOutcomeData <- allOutcomeData[!is.na(allOutcomeData[outcomeCol]), c(2, 7, outcomeCol)]
        
        ##user order to sort DF by col 2 then col 1
        myOutcomeData <- myOutcomeData[order(myOutcomeData[,2], myOutcomeData[,3], myOutcomeData[,1]),]
        
        ##split data by state
        statetables <- split(myOutcomeData, myOutcomeData[2])
        
        #resolve best|worse|int for rank
        if(!is.numeric(num)){
                if(num == "best"){
                        num <-  1
                } else if(num == "worst") {
                        worstFlag <- TRUE
                } else {
                        stop("invalid rank passed")
                }
                
        }
        
        #make results dataframe
        results <- data.frame(states)
        rownames(results) <- states
        for(i in seq_along(statetables)) {
                if(worstFlag){ num <- nrow(statetables[[i]])}
                results[i,1:2] <- statetables[[i]][num,1:2]
        }
        
        colnames(results) <- c("hospital", "state")
        
        
        ##return result
        results
        
}



#outcome <- "heart attack"
#outcome <- "heart failure"
outcome <- "pneumonia"
#outcome <- "invalid"
#num = 20
#num <- "best"
num <- "worst"
#num <- "wrong"


##read outcome data
allOutcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

## get distinct list of states
states = sort(unique(allOutcomeData[,7]))

## set outcome column and test for invalid outcome
if(outcome == "heart attack"){
        outcomeCol <-  11
} else if(outcome == "heart failure"){
        outcomeCol <- 17
} else if(outcome == "pneumonia") {
        outcomeCol <- 23
} else {
        stop("invalid outcome")
}



##set outcome to numeric
allOutcomeData[, outcomeCol] <- as.numeric(allOutcomeData[,outcomeCol])

##subset for not NA, get name, state and outcome
myOutcomeData <- allOutcomeData[!is.na(allOutcomeData[outcomeCol]), c(2, 7, outcomeCol)]

##user order to sort DF by col 2 then col 1
myOutcomeData <- myOutcomeData[order(myOutcomeData[,2], myOutcomeData[,3], myOutcomeData[,1]),]

##split data by state
statetables <- split(myOutcomeData, myOutcomeData[2])

#resolve best|worse|int for rank
if(!is.numeric(num)){
        if(num == "best"){
                num <-  1
        } else if(num == "worst") {
                worstFlag <- TRUE
        } else {
                stop("invalid rank passed")
        }
                
}

#make results dataframe
results <- data.frame(states)
rownames(results) <- states
for(i in seq_along(statetables)) {
        if(worstFlag){ num <- nrow(statetables[[i]])}
        results[i,1:2] <- statetables[[i]][num,1:2]
}

colnames(results) <- c("hospital", "state")

##return result
head(results, 10)
tail(results, 3)


