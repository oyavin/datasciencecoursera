# worspace init
# load libraries
library(scales)
# read data
payments<-read.csv("payments.csv")
# scale relevant numbers by thousands
payments$Average.Covered.Charges<-payments$Average.Covered.Charges/1000
payments$Average.Total.Payments<-payments$Average.Total.Payments/1000

# to find out how many subplots are needed I used length(unique(payments$variable)

# prepare plot space and characteristics
# find range for all graphs to make them same scale
xrange<-round(range(payments$Average.Covered.Charges,na.rm=T))
yrange<-round(range(payments$Average.Total.Payments,na.rm=T))

# reset plot parameters
dev.off()
dev.set(2)
par(mfrow=c(6,6),mar=c(0,0,0,0),oma=c(4,4,2,1),mgp = c(2, 0.5, 0),tcl=-0.3)

i=0 # use to define plot index for later use (ticks)

# for each state and for each medical condition
for(state in unique(payments$Provider.State)){
        for (condition in unique(payments$DRG.Definition)){
                i=i+1 # advance index
                # take just the number of the condition from the name as an abreviation
                abrvCond<-strsplit(condition,split=" ")[[1]][1]
                # subset the data
                data<-subset(payments,Provider.State==state & DRG.Definition==condition)
                # plot
                with(data,plot(Average.Covered.Charges,Average.Total.Payments,
                               xlim=c(xrange[1],xrange[2]),ylim=c(yrange[1],yrange[2]),
                               xlab="",ylab="",xaxt='n',yaxt='n',
                               pch=20,col=rgb(0,0,1,alpha=0.2)))
                abline(reg = coef(with(data,lm(Average.Total.Payments~Average.Covered.Charges))),lwd=2,lty=2)
                # add ticks to just outer graphs
                if (i %in% c(31:36))
                        axis(1, at = seq(0,xrange[2],50))
                if (i %in% c(1,7,13,19,25,31))
                        axis(2, at = seq(0,yrange[2],10))
                # add unique mark showing which state, condition are reffered in each graph
                mtext(paste(state,abrvCond,sep=","), side = 3, line = -1, adj = 0.1, cex = 0.6)
        }
}

# add title, axis lables, remarks etc.
title(main="Mean covered charges vs. mean total payments (by State vs. Medical Condition)",cex.main=1.25,outer=T)
mtext("Mean covered charges in thousand dollars",side=1,outer = T,line=2)
mtext("Mean total payments in thousand dollars",side=2,outer = T,line=2)
mtext("* Each graph is labeled by \'STATE, CONDITION\', where condition is marked by a correalting number (as taken from the data).",
      side=1,outer = T,line=3,cex=0.6)

## save to pdf
dev.copy(pdf,file="plot2.pdf")
dev.off()