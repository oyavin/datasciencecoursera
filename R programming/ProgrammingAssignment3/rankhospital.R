rankhospital<-function(state, outcome, num = "best"){
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## set column number to be checked according the outcome queried
        if (outcome=="heart attack") col=11
        else if (outcome=="heart failure") col=17
        else if (outcome=="pneumonia") col=23
        else stop("invalid outcome") # stop if queried outcome is not recognized
        
        ## check if the state queried exists in the list
        state_count<-table(data$State)
        if (is.na(state_count[state])) stop("invalid state")
        
        ## prepare data
        filtered_data<-data[data$State==state,] # select only state data
        filtered_data<-filtered_data[complete.cases(filtered_data[,col]),] # remove NAs
        filtered_data<-filtered_data[!(filtered_data[,col]=="Not Available"),] # remove explicit NAs
        filtered_data[,col]<-as.numeric(filtered_data[,col]) #turn to numeric for ordering
        
        ## define the rank of the hospital
        suppressWarnings(rank<-as.numeric(num))
        if (is.na(rank)){
                if (num=="worst") rank=nrow(filtered_data)
                else rank=1
        }
        
        if (nrow(filtered_data)<rank) return(NA)
        
        ## order the data by parameter and then by hospital name
        ordered_data<-filtered_data[order(filtered_data[col],filtered_data["Hospital.Name"]),]
        
        return(ordered_data[rank,"Hospital.Name"])
}
        