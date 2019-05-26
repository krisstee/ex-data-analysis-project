# Author: Kristijana A.
# Exploratory Data Analysis Week 4 Project
# Plot 4

library(lubridate)
library(dplyr)

setwd("ex-data-analysis-project")
data_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(data_url, "pminfo.zip", method="curl")
unzip("pminfo.zip")

# Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset SCC to get Fuel Comb - Comm/Institutional - Coal data
coal_comb <- subset(SCC, EI.Sector == "Fuel Comb - Comm/Institutional - Coal")
coal_comb_scc <- coal_comb$SCC
coal_comb_nei <- subset(NEI, SCC %in% coal_comb_scc)

png(filename="plot4.png")

# Plot
ggplot(coal_comb_nei,aes(x = factor(year),y = Emissions)) +
        geom_bar(stat="identity") +
        labs(x="year", y="Total PM2.5 Emissions in Tons") + 
        labs(title="PM2.5 Coal Combustion Source Emissions Across US from 1999-2008")

dev.off()
