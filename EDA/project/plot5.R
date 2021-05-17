# package
library(dplyr)
library(ggplot2)

download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        destfile = "data.zip")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?

# I classify motor vehicles and anything with type "ON-ROAD"
plot_data <- group_by(NEI, year) %>%
             filter(type == "ON-ROAD", fips == 24510)  %>%
             summarise(value = sum(Emissions))


png("plot5.png") # default height and weight is 480

ggplot(aes(x = year), data = plot_data) +
        geom_line(aes(y = value),  size = 1) +
        ggtitle("Emissions from Motor Vehicles in Balitmore City") +
        ylab("PM2.5 Emissions (Tons)") +
        xlab("")
dev.off()
