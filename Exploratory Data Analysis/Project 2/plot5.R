## workspace init
# load necessary libraries
library(plyr)
library(ggplot2)
# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## process data for plotting
# subset only relevant data
Baltimore_NEI<-subset(NEI,fips=="24510")
vehicleSCC<-SCC[grep("Vehicles$",SCC$EI.Sector),"SCC"]
only_vehicles_Baltimore_NEI<-subset(Baltimore_NEI,SCC %in% vehicleSCC)
# sum emission values by year
only_vehicles_Baltimore_NEI_by_year<-ddply(only_vehicles_Baltimore_NEI, .(year), summarize, Emissions = sum(Emissions))

## plot
par(mfrow=c(1,1))
with(only_vehicles_Baltimore_NEI_by_year,barplot(Emissions,names.arg = year))
title(main = "Motor Vehicle Related PM2.5 Emission Measured in Baltimore Per Year",cex.main=1 ,xlab = "Year",ylab = "Total PM2.5 Emission in Tons")

## save to png
dev.copy(png,file="plot5.png",width=480,height=480)
dev.off()