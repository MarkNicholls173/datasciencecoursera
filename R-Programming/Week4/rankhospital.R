rankhospital <- function(state, outcome, num = "best"){
        ## state:       character abbrevation for state
        ## outcome:     one of "heart attack", "heart failuer" or "pnuemonia"
        ## num:          ranking of hospital in that outcome (best|worse or int rank)
        ##
        ## return character vector with name of hospital
        ##
        ## if num is larger than the number of hospitals in that state return NA
        ##
        ## columns of interest
        ## [2] Hospital.Name
        ## [7] State
        ## [11] heart attack mortality
        ## [17] heart failure mortality
        ## [23] pnuemonia mortality
        ##
        ## validate inputs state is valid and outcome is one of the 3
        ## stop "invalid state|outcome"
        ##
        ## ties: return all results alphabetically
        
        ##read outcome data
        allOutcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## get distinct list of states
        states = sort(unique(allOutcomeData[,7]))
        

        ## test to see if state is in list of states
        ## stop if match not found
        if(!any(states == state)){ stop("invalid state") }
        
        
        ## set outcome column and test for invalid outcome
        if(outcome == "heart attack"){
                outcomeCol <-  11
        } else if(outcome == "heart failure"){
                outcomeCol <- 17
        } else if(outcome == "pnuemonia") {
                outcomeCol <- 23
        } else {
                stop("invalid outcome")
        }
        
        ##subset for state, get name and outcome result
        myOutcomeData <- allOutcomeData[allOutcomeData[7] == state, c(2, outcomeCol)]
        ##set outcome to numeric
        myOutcomeData[,2] <- as.numeric(myOutcomeData[,2]) 
        
        ##filter for NA
        myOutcomeData <- myOutcomeData[!is.na(myOutcomeData[2]), ]
        
        ##user order to sort DF by col 2 then col 1
        myOutcomeData <- myOutcomeData[order(myOutcomeData[,2], myOutcomeData[, 1]),]
        
        #resolve best|worse|int for rank
        if(!is.numeric(num)){
                if(num == "best"){
                        num <-  1
                } else if(num == "worst") {
                        num <- nrow(myOutcomeData)
                } else {
                        stop("invalid rank passed")
                }
                
        }
        
        ##return result
        myOutcomeData[num, 1]
        
}


state <-  "TX"
#state <-  "BB"
#outcome <- "heart attack"
outcome <- "heart failure"
#outcome <- "pnuemonia"
#outcome <- "invalid"
num = 4
#num <- "best"
#num <- "worst"
#num <- "wrong"


##read outcome data
allOutcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
#outcome[, 11] <-  as.numeric(outcome[,11])

## get distinct list of states
states = sort(unique(allOutcomeData[,7]))

## test to see if state is in list of states
# stop if match not found
if(!any(states == state)){ stop("invalid state") }


## set outcome column and test for invalid outcome
if(outcome == "heart attack"){
        outcomeCol <-  11
} else if(outcome == "heart failure"){
        outcomeCol <- 17
} else if(outcome == "pnuemonia") {
        outcomeCol <- 23
} else {
        stop("invalid outcome")
}


##subset for state, get name and outcome result
myOutcomeData <- allOutcomeData[allOutcomeData[7] == state, c(2, outcomeCol)]
##set outcome to numeric
myOutcomeData[,2] <- as.numeric(myOutcomeData[,2]) 

##filter for NA
myOutcomeData <- myOutcomeData[!is.na(myOutcomeData[2]), ]

##user order to sort DF by col 2 then col 1
myOutcomeData <- myOutcomeData[order(myOutcomeData[,2], myOutcomeData[, 1]),]

#resolve best|worse|int for rank
if(!is.numeric(num)){
        if(num == "best"){
                num <-  1
        } else if(num == "worst") {
                num <- nrow(myOutcomeData)
        } else {
                stop("invalid rank passed")
        }
                
}

##return result
myOutcomeData[num, 1]


