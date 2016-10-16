## workspace init
#load needed libraries
library(lubridate)
# read data
power<-read.csv("household_power_consumption.txt",sep = ";",na.strings = "?",header = T)
#subset relevant data
data<-subset(as.data.frame(power),Date=="1/2/2007"|Date=="2/2/2007")
# create a timeline, time and date combined
timeline<-with(data,as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")))

## plot
# set plot parameters
par(mfrow=c(1,1))
# create empty plot canvas
plot(data$Global_active_power~timeline,xlab = "",ylab = "Global Active Power (kilowatts)",type="n")
# plot the lines
lines(data$Global_active_power~timeline,type="l")

# save to png
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()