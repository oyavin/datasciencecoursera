## workspace init
# read data
power<-read.csv("household_power_consumption.txt",sep = ";",na.strings = "?",header = T)
#subset relevant data
data<-subset(as.data.frame(power),Date=="1/2/2007"|Date=="2/2/2007")

## plot
par(mfrow=c(1,1))
hist(data$Global_active_power, col = "red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

## save to png
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()