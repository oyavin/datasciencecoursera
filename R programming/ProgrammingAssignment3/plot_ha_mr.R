plot_ha_mr<-function(){
        outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        outcome[, 11] <- as.numeric(outcome[, 11]) # prepare relevant data as numeric to be plotted
        hist(outcome[, 11])
}
