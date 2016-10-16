rankall<-function(outcome, num = "best") {
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## set column number to be checked according the outcome queried
        if (outcome=="heart attack") col=11
        else if (outcome=="heart failure") col=17
        else if (outcome=="pneumonia") col=23
        else stop("invalid outcome") # stop if queried outcome is not recognized
        
        ## prepare data
        #filtered_data<-data[data$State==state,c("State","Hospital.Name",col)] # select only state data
        filtered_data<-data[complete.cases(data[,col]),] # remove NAs
        filtered_data<-filtered_data[!(filtered_data[,col]=="Not Available"),] # remove explicit NAs
        filtered_data[,col]<-as.numeric(filtered_data[,col]) #turn to numeric for ordering
        
        ## define the rank of the hospital
        suppressWarnings(rank<-as.numeric(num))
        if (is.na(rank)){
                if (num=="worst") rank=0
                else rank=1
        }
        
        ## order the data by parameter and then by hospital name
        ordered_data<-filtered_data[order(filtered_data[col],filtered_data["Hospital.Name"]),]
        by_state<-split(ordered_data,ordered_data$State)
        
        ## finalize list and create data frame
        if (rank==0) final_list<-sapply(by_state,function(x) x[nrow(x),"Hospital.Name"])
        else final_list<-sapply(by_state,function(x) x[rank,"Hospital.Name"])
        final_df<-data.frame(hospital=final_list[],state=names(final_list),row.names = names(final_list))
}