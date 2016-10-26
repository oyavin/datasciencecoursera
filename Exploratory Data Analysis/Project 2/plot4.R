## workspace init
# load necessary libraries
library(plyr)
# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## process data for plotting
# subset data
coalSCC<-SCC[grep("- Coal$",SCC$EI.Sector),"SCC"]
only_coal_NEI<-subset(NEI,SCC %in% coalSCC)
# sum emission values by year
only_coal_NEI_by_year<-ddply(only_coal_NEI, .(year), summarize, Emissions = sum(Emissions)/(10^3))

## plot
par(mfrow=c(1,1))
with(only_coal_NEI_by_year,barplot(Emissions,names.arg = year))
title(main = "Total Coal-Combustion-Related PM2.5 Emission Measured in the US Per Year",cex.main=1 ,xlab = "Year",ylab = "Total PM2.5 Emission in Kilotons")

## save to png
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()