# package
library(dplyr)

download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        destfile = "data.zip")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland fips == "24510" from 1999 to 2008? 

# Use the base plotting system to make a plot answering this question.

plot_data <- group_by(NEI, year) %>%
             filter(fips == 24510) %>%
             filter(year == 1999 | year == 2008) %>%
             summarise(value = sum(Emissions))


png("plot2.png") # default height and weight is 480
barplot(value ~ year, plot_data,
        main = "Comparison of PM2.5 Emissions for Baltimore City 1999 to 2008",
        xlab = "",
        ylab = "PM2.5 Emissions (Tons)",
        col = "wheat")
dev.off()
