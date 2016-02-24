## Course Project 4-2. Exploratory Data Analysis
## Plot # 1 by A. Neverov
## Question: Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, make a plot showing 
## the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


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

## Summarize values of the Emission by Year

t <- tapply(NEI$Emission, factor(NEI$year), sum, na.rm = TRUE)
t <- t/1000

## Plot a histogram to show the changes of total emission from PM2.5
## in the United States from 1999 to 2008

par(mfrow = c(1,1))
barplot(t, xlab = "Year", ylab = "PM2.5 Emission, k.tonns")
title("Total emission from the PM2.5 in the USA from 1999 to 2008")

## Copy the graph into the png file

dev.copy(png, "plot1.png")
dev.off()


