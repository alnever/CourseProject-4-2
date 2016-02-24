## Course Project 4-2. Exploratory Data Analysis
## Plot # 4 by A. Neverov
## Question: Across the United States, how have emissions 
## from coal combustion-related sources changed from 1999–2008? 

## library(ggplot2)

## Read datasets
if (!file.exists("summarySCC_PM25.rds")) {
	if (!file.exitst("exdata_data_NEI_data.zip"))
	{
		fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
		file.download(fileUrl, "exdata_data_NEI_data.zip")
	}
	unzip("exdata_data_NEI_data.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset coal combustion-related sources
coal <- subset(SCC, grepl("Coal",EI.Sector) & grepl("Fuel Comb",EI.Sector))
emcoal <- subset(NEI, SCC %in% coal$SCC)

## Create data for plotting

### Calculate total PM2.5 emissions
t <- tapply(emcoal$Emissions, factor(emcoal$year), sum)
t <- t / 1000

### Calculate number of pollutants
n <- sapply(split(emcoal$SCC, factor(emcoal$year)), length)

### Calculate number of coal combustion-related sources
### with zero PM2.5 emissions
emcoal0 <- subset(emcoal, Emissions == 0)
n0 <- sapply(split(emcoal0$SCC, factor(emcoal0$year)), length)

### Calculate average PM2.5 emissions for pollutants
### with non-zero PM2.5 emissions
emcoal1 <- subset(emcoal, Emissions != 0) 
t1 <- tapply(emcoal1$Emissions, factor(emcoal1$year), mean)
n1 <- sapply(split(emcoal1$SCC, factor(emcoal1$year)), length)

### Bind sources with 0- and non-0-emissions of PM2.5
s <- rbind(n0, n1)

# Plot diagrams

par(mfrow = c(1,3), cex.axis = 1.2, cex.lab = 1.5)
barplot(t, xlab = "Year", ylab = "PM2.5 Emission, k.tonns")
title("Total PM2.5 emission")
lines(t, col = "blue", lwd = 2, type = "b")

barplot(s, xlab = "Year", ylab = "Number of sources", col = c("green", "red"), ylim = c(0,10000))
legend("topright", legend = c("0-emission", "non 0-emission"), 
       col = c("green", "red"), pch = 15, cex = 1.5 )
title("Coal combustion sources")

## with(emcoal1, boxplot(Emissions ~ year, xlab = "Year", ylab = "PM2.5 Emission, tonns"))
barplot(t1, xlab = "Year", ylab = "PM2.5 Emission, tonns")
lines(t1, col = "magenta", lwd = 2, type = "b")
title(main = "Average PM2.5 emission", sub = "for sources with non-0-emissions")

## Copy the graph into the png file

dev.copy(png, "plot4.png", width = 720)
dev.off()