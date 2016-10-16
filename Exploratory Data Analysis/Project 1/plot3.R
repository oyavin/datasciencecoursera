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
plot(data$Sub_metering_1~timeline,xlab = "",ylab = "Energy sub metering",type="n")
# plot the lines
lines(data$Sub_metering_1~timeline,type="l",col="black")
lines(data$Sub_metering_2~timeline,type="l",col="red")
lines(data$Sub_metering_3~timeline,type="l",col="blue")
# add legend
legend("topright",lty = c(1,1,1), col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# save to png
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()