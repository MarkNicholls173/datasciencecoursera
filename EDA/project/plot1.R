# package
library(dplyr)

download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        destfile = "data.zip")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? 
# 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# df which shows sum(pollutant) by year

plot_data <- group_by(NEI, year) %>%
             summarise(value = sum(Emissions))


png("plot1.png") # default height and weight is 480
barplot(value ~ year, plot_data,
        main = "Total PM2.5 Emissions by Year",
        xlab = "",
        ylab = "PM2.5 Emissions (Millions of tons)",
        col = "wheat",
        yaxt = "n")
y_ticks = axTicks(2)
axis(2, at = y_ticks, labels = format(y_ticks / 1e06, scientific = FALSE))
dev.off()
