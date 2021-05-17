# package
library(dplyr)
library(ggplot2)

download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        destfile = "data.zip")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases 
# in emissions from 1999–2008 for Baltimore City? Which have seen increases 
# in emissions from 1999–2008? 

# Use the ggplot2 plotting system to make a plot answer this question.

plot_data <- group_by(NEI, year, type) %>%
             filter(fips == 24510) %>%
             summarise(value = sum(Emissions))


png("plot3.png") # default height and weight is 480

ggplot(aes(x = year), data = plot_data) +
        geom_line(aes(y = value, col = type),  size = 1) +
        ggtitle("Sources of PM2.5 Emissions in Balitmore City") +
        ylab("PM2.5 Emissions (Tons)") +
        xlab("") +
        theme(legend.title=element_blank()) +
        labs(caption = "Deacreased: NON-ROAD, NONPOINT & ON-ROAD 
                        Increased: POINT")

dev.off()
