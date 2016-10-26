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
# sum emission values by year AND by type
Baltimore_NEI_by_yearvstype<-ddply(Baltimore_NEI, .(year,type), summarize, Emissions = sum(Emissions))

## plot
g<-ggplot(data=Baltimore_NEI_by_yearvstype,aes(year,Emissions,color=type))+
        geom_line()+
        xlab("Year")+
        ylab("Total PM2.5 Emission in Tons")+
        ggtitle("PM2.5 Emission Measured in Baltimore Per Year, by type")
print(g)

## save to png
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()