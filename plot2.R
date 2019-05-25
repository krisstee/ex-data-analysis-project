# Author: Kristijana A.
# Exploratory Data Analysis Week 4 Project
# Plot 2

library(lubridate)
library(dplyr)

setwd("ex-data-analysis-project")
data_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(data_url, "pminfo.zip", method="curl")
unzip("pminfo.zip")

# Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset NEI to get Balitmore data
baltimore <- subset(NEI, fips == "24510")

# sum emissions column by year
totalPM <- baltimore %>%
            group_by(year) %>%
            summarise(Emissions = sum(Emissions))

# start PNG file
png(filename = "plot2.png")

rng <- range(totalPM$Emissions)

# plot
barplot(totalPM$Emissions, names=totalPM$year, xlab="Year",
        ylab="Total PM2.5 Emissions",
        main="Total PM2.5 Emissions by Year")

dev.off()
