require(dplyr)
source("download_EDA_data.R")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$year <- as.factor(NEI$year)

# Group by year and aggregate total emissions
by_year <- group_by(NEI, year)
by_year_sum <- summarise(by_year, Emissions = sum(Emissions))

# Plot data using base graphics and save
png(filename="./EDA_Assignment2/plot1.png")
barplot(by_year_sum$Emissions, names.arg = by_year_sum$year, col = "indianred3",
        main = "Total Emission in the US from 1999 - 2008", axis.lty = 1,
        xlab = "Year", ylab = expression(paste("PM",  ''[2.5], " in tons")))
dev.off()