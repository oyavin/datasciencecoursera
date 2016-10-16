### workspace init
# read data
power<-read.csv("household_power_consumption.txt",sep = ";",na.strings = "?",header = T)
#subset relevant data
data<-subset(as.data.frame(power),Date=="1/2/2007"|Date=="2/2/2007")
# create a timeline, time and date combined
timeline<-with(data,as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")))

### plot
# set plot parameters
par(mfcol=c(2,2),cex.lab=0.75)

## plot 1
# create empty plot canvas
plot(data$Global_active_power~timeline,xlab = "",ylab = "Global Active Power (kilowatts)",type="n")
# plot the lines
lines(data$Global_active_power~timeline,type="l")

## plot 2
# create empty plot canvas
plot(data$Sub_metering_1~timeline,xlab = "",ylab = "Energy sub metering",type="n")
# plot the lines
lines(data$Sub_metering_1~timeline,type="l",col="black")
lines(data$Sub_metering_2~timeline,type="l",col="red")
lines(data$Sub_metering_3~timeline,type="l",col="blue")
# add legend
legend("topright",lty = c(1,1,1), col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",cex=0.75)

## plot 3
# create empty plot canvas
plot(data$Voltage~timeline,xlab = "datetime",ylab = "Voltage",type="n")
# plot the lines
lines(data$Voltage~timeline,type="l")

## plot 4
# create empty plot canvas
plot(data$Global_reactive_power~timeline,xlab = "datetime",ylab = "Global_reactive_power",type="n")
# plot the lines
lines(data$Global_reactive_power~timeline,type="l",lwd=0.25)

# save to png
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()