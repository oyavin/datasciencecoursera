# worspace init
# load libraries
library(scales)
# read data
payments<-read.csv("payments.csv")
# scale relevant numbers by thousands
payments$Average.Covered.Charges<-payments$Average.Covered.Charges/1000
payments$Average.Total.Payments<-payments$Average.Total.Payments/1000

# subset only NY state data
payments_NY<-subset(payments,Provider.State=="NY")

# reset plot parameters
dev.off()
dev.set(2)
par(mfrow=c(1,1))

# plot
with(payments_NY,plot(Average.Covered.Charges,Average.Total.Payments,xlab="Mean covered charges in thousand dollars",ylab="Mean total payments in thousand dollars",pch=20,col=rgb(0,0,1,alpha=0.2)))
abline(reg = coef(with(payments_NY,lm(Average.Total.Payments~Average.Covered.Charges))),lwd=2,lty=2)
title(main="Mean covered charges vs. mean total payments in NY state")

# save to pdf
dev.copy(pdf,file="plot1.pdf")
dev.off()