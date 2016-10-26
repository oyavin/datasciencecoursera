#Codebook
### for 'Exploratory Data Analysis' project #2
### by Omer Yavin
Following is a description of the data used, the outcome, and the manipulation implemented in between.

##Data overview
The data consists of 2 tables, one obtained from a different file.
One table holds pollutant measurements by year, source type (by a numeric classification code) and area, the other holds a 'dicitionary' for the source classification codes.
The specific data I wored with here holds data for **1999, 2002, 2005, and 2008**.
More information can be found in the README file or at the **EPA National Emissions Inventory web site**.

##Files overview
* **summarySCC_PM25.rds:** Holds the emission values table.
* **Source_Classification_Code.rds:** Holds the classification codes "dicitionary".

##Files used or created during the run
**plot[1-6].R:** each holds the code to creat the graph with the correlating number according the the order of the questions as specified in the README file.

##Outcome
* **plot1** - Total PM2.5 Emission Measured in the US Per Year
* **plot2** - PM2.5 Emission Measured in Baltimore Per Year
* **plot3** - PM2.5 Emission Measured in Baltimore Per Year, by type
* **plot4** - Total Coal-Combustion-Related PM2.5 Emission Measured in the US Per Year
* **plot5** - Motor Vehicle Related PM2.5 Emission Measured in Baltimore Per Year
* **plot6** - Motor Vehicle Related PM2.5 Emission Measured in LA vs. Baltimore Per Year

##Data cleaning\tidying process
Each code reads the data from the files, subsets the relevant data and utilizes ddply to calculate the sum of emissions across certain factors (mostly per year).
In plots 4-6 it was necessary to use the source type 'dictionary' to find relevant rows of the data as requested.
In plot 6, two seperate data frames were created for each city, and then merged while adding the name of the city\county as a factor in a new row to use for coloring the graph.

* Variables in all plot codes are named to be self-explanatory.
* For questions regarding trends in emissions I would control for new opints introduced over the years, but the data was not sufficiently marked for this + it does not seem this is the focus of the project.