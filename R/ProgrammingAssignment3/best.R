best<-function(state,outcome){
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## set column number to be checked according the outcome queried
        if (outcome=="heart attack") col=11
        else if (outcome=="heart failure") col=17
        else if (outcome=="pneumonia") col=23
        else stop("invalid outcome") # stop if queried outcome is not recognized
        
        ## check if the state queried exists in the list
        state_count<-table(data$State)
        if (is.na(state_count[state])) stop("invalid state")
        
        ## extract only the relevant data
        filtered_data<-data[data$State==state,c(2,col)]
        if (nrow(filtered_data)==0) stop(NA) # stop if no data is found
        
        # find and return the name of the best hospital under queried parameters
        suppressWarnings(best_index<-which.min(as.numeric(filtered_data[,2]))) # index for best hospital
        best<-filtered_data[best_index,] # extract data for best hospital
        best<-best[order(best[,1]),] # order alphabetically incase of tie
        best$Hospital.Name[1]
}