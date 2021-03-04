# package
library(dplyr)

download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
        destfile = "data.zip")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# Use the base plotting system to make a plot answering this question.

# I classify coal sources as EI.Sector containing "Fuel Comb"(combustion) and
# SCC.Level.Three containing "Coal"
coal_sources <- SCC %>%
                filter(grepl("Fuel Comb", EI.Sector)) %>%
                filter(grepl("Coal", SCC.Level.Three)) %>%
                select(SCC)

plot_data <- NEI %>%
             filter(SCC %in% coal_sources$SCC) %>%
             group_by(year) %>%
             summarise(value = sum(Emissions))

png("plot4.png") # default height and weight is 480

barplot(value ~ year, plot_data,
        main = "National PM2.5 Emissions from Coal Combustion Sources",
        xlab = "",
        ylab = "PM2.5 Emissions (Tons)",
        col = "wheat",
        yaxt = "n")
y_ticks <- axTicks(2)
axis(2, at = y_ticks, labels = format(y_ticks, scientific = FALSE))

dev.off()
