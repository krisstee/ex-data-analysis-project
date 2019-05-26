# Author: Kristijana A.
# Exploratory Data Analysis Week 4 Project
# Plot 6

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
baltimore_vehicle <- subset(baltimore, SCC %in% vehicle_scc_list)

# subset NEI to get L.A. data
la <- subset(NEI, fips == "06037")
# subset la to get vehicle related data
la_vehicle <- subset(la, SCC %in% vehicle_scc_list)

# bind the graphs
baltimore_la <- rbind(baltimore_vehicle, la_vehicle)

# Add city column
baltimore_la$city <- NA
# Label which rows are associated with L.A.
baltimore_la <- baltimore_la %>% mutate(city = replace(city,
                                              which(is.na(city) & 
                                              fips == "06037"),
                                              "Los Angeles"))
# Label which rows are associated with Baltimore
baltimore_la <- baltimore_la %>% mutate(city = replace(city,
                                                       which(is.na(city) & 
                                                        fips == "24510"),
                                                       "Baltimore"))

# Start png
png(filename="plot6.png")

# Plot
ggplot(baltimore_la, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="Year", y="Total PM2.5 Emissions in Tons") + 
  labs(title="PM2.5 Motor Vehicle Emissions in Baltimore & LA")

dev.off()
