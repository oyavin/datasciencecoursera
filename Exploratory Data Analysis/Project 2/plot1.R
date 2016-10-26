## workspace init
# load necessary libraries
library(plyr)
# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## process data for plotting
# sum emission values by year
NEI_by_year<-ddply(NEI, .(year), summarize, Emissions = sum(Emissions)/(10^6))

## plot
par(mfrow=c(1,1))
with(NEI_by_year,barplot(Emissions,names.arg = year))
title(main = "Total PM2.5 Emission Measured in the US Per Year" ,xlab = "Year",ylab = "Total PM2.5 Emission in Megatons")

## save to png
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()