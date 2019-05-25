# Author: Kristijana A.
# Exploratory Data Analysis Week 4 Project
# Plot 3

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

# Start PNG
png(filename="plot3.png")

#Plot
ggplot(baltimore,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        facet_grid(.~type,scales = "free",space="free") + 
        labs(x="year", y="Total PM2.5 Emissions") + 
        labs(title="PM2.5 Emissions in Baltimore City 1999-2008 by Source") +
        theme(axis.text.x = element_text(angle=45))

dev.off()
