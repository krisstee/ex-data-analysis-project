# Author: Kristijana A.
# Exploratory Data Analysis Week 4 Project
# Plot 5

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
# subset SCC to get vehicle related data
vehicle_collection <- condition <- grepl("vehicle", SCC[, "SCC.Level.Two"], ignore.case=TRUE)
# subset baltimore to get vehicle related data
vehicle_scc <- SCC[vehicle_collection,]
vehicle_scc_list <- vehicle_scc$SCC
vehicle_nei <- subset(NEI, SCC %in% vehicle_scc_list)

# Start png
png(filename="plot5.png")
ggplot(vehicle_nei,aes(factor(year),Emissions)) +
        geom_bar(stat="identity") +
        labs(x="year", y="Total PM2.5 Emissions in Tons") + 
        labs(title="PM2.5 Motor Vehicle Emissions in Baltimore from 1999-2008")

dev.off()
