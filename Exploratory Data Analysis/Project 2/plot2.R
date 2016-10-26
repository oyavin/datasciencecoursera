## workspace init
# load necessary libraries
library(plyr)
# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## process data for plotting
# subset only relevant data
Baltimore_NEI<-subset(NEI,fips=="24510")
# sum emission values by year
Baltimore_NEI_by_year<-ddply(Baltimore_NEI, .(year), summarize, Emissions = sum(Emissions))

## plot
par(mfrow=c(1,1))
with(Baltimore_NEI_by_year,barplot(Emissions,names.arg = year))
title(main = "PM2.5 Emission Measured in Baltimore Per Year" ,xlab = "Year",ylab = "Total PM2.5 Emission in Tons")

## save to png
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()
