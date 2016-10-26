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
LA_NEI<-subset(NEI,fips=="06037")
vehicleSCC<-SCC[grep("Vehicles$",SCC$EI.Sector),"SCC"]
only_vehicles_Baltimore_NEI<-subset(Baltimore_NEI,SCC %in% vehicleSCC)
only_vehicles_LA_NEI<-subset(LA_NEI,SCC %in% vehicleSCC)
# sum emission values by year
only_vehicles_Baltimore_NEI_by_year<-ddply(only_vehicles_Baltimore_NEI, .(year), summarize, Emissions = sum(Emissions)/(10^3))
only_vehicles_LA_NEI_by_year<-ddply(only_vehicles_LA_NEI, .(year), summarize, Emissions = sum(Emissions)/(10^3))
# create city labels to use as factors for the colors of the plot
only_vehicles_LA_NEI_by_year$city<-rep("LA",4)
only_vehicles_Baltimore_NEI_by_year$city<-rep("Baltimore",4)
only_vehicles_LA_vs_Balt_by_year<-rbind(only_vehicles_LA_NEI_by_year,only_vehicles_Baltimore_NEI_by_year)
only_vehicles_LA_vs_Balt_by_year$city<-as.factor(only_vehicles_LA_vs_Balt_by_year$city)

## plot
g<-ggplot(data=only_vehicles_LA_vs_Balt_by_year,aes(year,Emissions,color=city))+
        geom_line()+
        xlab("Year")+
        ylab("Total PM2.5 Emission in Kilotons")+
        ggtitle("Motor Vehicle Related PM2.5 Emission Measured in LA vs. Baltimore Per Year")+
        theme(plot.title = element_text(size=11,face="bold"))
print(g)

## save to png
dev.copy(png,file="plot6.png",width=480,height=480)
dev.off()