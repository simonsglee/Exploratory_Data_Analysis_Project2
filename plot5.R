require(dplyr)
require(ggplot2)
source("download_EDA_data.R")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$year <- as.factor(NEI$year)

# Subset for city of Baltimore and type
bal_onroad <- subset(NEI, fips == "24510" & type == "ON-ROAD")

# Group by type and year, summarise data
bal_onroad_year <- group_by(bal_onroad, year)
bal_onroad_sum <- summarise(bal_onroad_year, Emissions = sum(Emissions))

# Plot data using ggplot
plot5 <- ggplot(bal_onroad_sum, aes(x = year, y = Emissions))
plot5 <- plot5 + geom_bar(stat = "identity", fill = "peru")
plot5 <- plot5 + ggtitle("Total Emissions from On-Road Sources in Baltimore")
plot5 <- plot5 + xlab("Year") + ylab(expression(paste("PM",  ''[2.5], " in tons")))

# Print and save plot
png(filename = "./EDA_Assignment2/plot5.png", type = "cairo")
print(plot5)
dev.off()
