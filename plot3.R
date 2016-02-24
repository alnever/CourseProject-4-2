## Course Project 4-2. Exploratory Data Analysis
## Plot # 3 by A. Neverov
## Question: Of the four types of sources indicated by the type 
## (point, nonpoint, onroad, nonroad) variable, which of these four 
## sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 

library(ggplot2)

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

## Subset the data for emission from the PM2.5 in Baltimore City, MD
sub <- subset(NEI, fips == "24510")


## Create plot

g <- ggplot(sub, aes(factor(year), log10(Emissions)))
## aes(group = cut_width(year,3)),
g <- g + geom_boxplot( size = 1, outlier.colour = "red" )
g <- g + geom_jitter(width = 0.2, aes(color = year), alpha = 1/2)
g <- g + facet_wrap(~ type, ncol = 2)
g <- g + geom_smooth(method = "loess", na.rm = TRUE)
g <- g + labs(y = expression("log " * PM[2.5]), x = "Years")
g <- g + labs(title  = "Emissions PM2.5 in the Baltimore City, MD from 1999–2008")
print(g)

## Copy the graph into the png file

dev.copy(png, "plot3.png")
dev.off()