require(dplyr)
require(ggplot2)
source("download_EDA_data.R")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$year <- as.factor(NEI$year)

# Subset for city of Baltimore and type
bal_onroad <- subset(NEI, fips == "24510" & type == "ON-ROAD")
la_onroad <- subset(NEI, fips == "06037" & type == "ON-ROAD")

# Group by year and aggregate data
bal_onroad_year <- group_by(bal_onroad, year)
bal_onroad_sum <- summarise(bal_onroad_year, Emissions = sum(Emissions))
la_onroad_year <- group_by(la_onroad, year)
la_onroad_sum <- summarise(la_onroad_year, Emissions = sum(Emissions))

# Add column for city
bal_la_sum <- rbind(bal_onroad_sum, la_onroad_sum)
bal_la_sum$city <- rep("BAL", 4)
bal_la_sum$city[5:8] <- rep("LA", 4)

# Plot data
plot6 <- ggplot(bal_la_sum, aes(x = year, y = log(Emissions)))
plot6 <- plot6 + geom_bar(stat = "identity", aes(fill = city), show.legend = FALSE) + facet_wrap(~ city)
plot6 <- plot6 + ggtitle("Emission from ON-ROAD Sources in Baltimore and Los Angeles in log scale")
plot6 <- plot6 + xlab("Year") + ylab(expression(paste("log(PM",  ''[2.5], " in tons)")))

# Print and save plot
png(filename = "./EDA_Assignment2/plot6.png", width = 800, height = 480, type = "cairo")
print(plot6)
dev.off()