require(dplyr)
source("download_EDA_data.R")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$year <- as.factor(NEI$year)

# Subset data for city of Baltimore
bal <- subset(NEI, fips == "24510")

bal_by_year <- group_by(bal, year)
bal_by_year_sum <- summarise(bal_by_year, Emissions = sum(Emissions))

# Plot data using base graphics and save
png(filename = "./EDA_Assignment2/plot2.png")
barplot(bal_by_year_sum$Emissions, names.arg = bal_by_year_sum$year, col = "darkslateblue",
        main = "Total Emission in Baltimore from 1999 - 2008", axis.lty = 1,
        xlab = "Year", ylab = expression(paste("PM",  ''[2.5], " in tons")))
dev.off()