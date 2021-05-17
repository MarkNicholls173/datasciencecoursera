# package
library(dplyr)
library(ggplot2)

download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        destfile = "data.zip")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California fips == "06037".

# Which city has seen greater changes over time in motor vehicle emissions?

# I classify motor vehicles to be any emission as type "On-ROAD"

plot_data <- NEI %>%
             filter(type == "ON-ROAD") %>%
             filter(fips == "06037" | fips == "24510") %>%
             group_by(year, fips) %>%
             mutate(fips = ifelse(fips=="06037",
                                  "Los Angeles", 
                                  "Baltimore City"))%>%
             summarise(value = sum(Emissions))


png("plot6.png") # default height and weight is 480
ggplot(aes(x = year), data = plot_data) +
        geom_line(aes(y = value, col = fips),  size = 1) +
        ggtitle("PM2.5 Emissions over time") +
        ylab("PM2.5 Emissions (Tons)") +
        xlab("") +
        theme(legend.title=element_blank()) +
        labs(caption = "Los Angeles has seen greater change over time")
dev.off()
