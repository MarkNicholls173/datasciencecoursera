best <- function(state, outcome){
        ## state 2 character abbrevation for state
        ## outcome one of "heart attack", "heart failuer" or "pnuemonia"
        ##
        ## return character vector with name of hospital with
        ## lowest 30 day mortality rate for outcome
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
        ## ties: return first result alphabetically
        
        ##read outcome data
        allOutcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## get distinct list of states
        states = sort(unique(allOutcomeData[,7]))
        
        ## set flag false
        #matchFound = FALSE
        
        ## test to see if state is in list of states
        #for(thisstate in states){
                #matchFound <- (thisstate == state)
                #if(matchFound){ break }
        #}
        
        # stop if match not found
        #if(!matchFound){
                #stop("invalid state")
        #}
        
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
        ##get names where outcome == minimum of outcome
        myResult <- sort(myOutcomeData[myOutcomeData[2] == min(myOutcomeData[2]), 1])
        ## sort results by alpha
        
        ##return result
        myResult[1]
        
        
}


#state <-  "MD"
state <-  "BB"
#outcome <- "heart attack"
#outcome <- "heart failure"
outcome <- "pnuemonia"
#outcome <- "invalid"


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
##get names where outcome == minimum of outcome
myResult <- sort(myOutcomeData[myOutcomeData[2] == min(myOutcomeData[2]), 1])
## sort results by alpha

##return result
myResult
