require(dplyr)
require(ggplot2)
source("download_EDA_data.R")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$year <- as.factor(NEI$year)

# Subset NEI data for city of Baltimore and merge with four type subset
bal <- subset(NEI, fips == "24510")

# Group by data category and year and summarize
bal_four <- group_by(bal, type, year)
bal_four_sum <- summarise(bal_four, Emissions = sum(Emissions))

# Plot a bar graph for each category in one window
plot3 <- ggplot(bal_four_sum, aes(x = year, y = Emissions))
plot3 <- plot3 + geom_line(aes(color = type, group = type), size = 1)
plot3 <- plot3 + ggtitle("Emission by Sources in Baltimore City") 
plot3 <- plot3 + xlab("Year") + ylab(expression(paste("PM",  ''[2.5], " in tons")))

# Print and save plot
png(filename = "./EDA_Assignment2/plot3.png", width = 800, height = 480, type = "cairo")
print(plot3)
dev.off()