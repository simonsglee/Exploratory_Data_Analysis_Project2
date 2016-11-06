require(dplyr)
require(ggplot2)
source("download_EDA_data.R")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$year <- as.factor(NEI$year)

# Find all source classification code with "Coal" in the short description and merge with NEI
coal <- SCC[grep("coal", SCC$Short.Name, ignore.case = TRUE),]
us_coal <- merge(NEI, coal, by = "SCC")

# Group by year and aggregate Emission totals
us_coal_by_year <- group_by(us_coal, year)
us_coal_by_year_sum <- summarise(us_coal_by_year, Emissions = sum(Emissions))

# Plot data using ggplot
plot4 <- ggplot(us_coal_by_year_sum, aes(x = year, y = Emissions))
plot4 <- plot4 + geom_bar(stat = "identity", fill = "darkseagreen")
plot4 <- plot4 + ggtitle("Total Emissions from Coal Combustion-Related Sources")
plot4 <- plot4 + xlab("Year") + ylab(expression(paste("PM",  ''[2.5], " in tons")))

# Print and save plot
png(filename = "./EDA_Assignment2/plot4.png", type = "cairo")
print(plot4)
dev.off()