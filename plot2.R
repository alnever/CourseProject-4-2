## Course Project 4-2. Exploratory Data Analysis
## Plot # 2 by A. Neverov
## Question: Have total emissions from PM2.5 decreased 
## in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 


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

## Calculate total emission from the PM2.5 in Baltimore City, MD
sub <- subset(NEI, fips == "24510")
t <- tapply(sub$Emission, factor(sub$year), sum, na.rm = TRUE)

## Plot to show the changes of total emission from PM2.5
## in the Baltimore City, Maryland from 1999 to 2008

par(mfrow = c(1,1))
plot(names(t), t, type = "h", lwd = 4, col = "blue", 
               xlab = "Year", ylab = "PM2.5 Emission, tonns")
abline(lm(t ~ as.numeric(names(t))), col = "green", lwd = 5)
title("Total emission from the PM2.5 in the Baltimore City, MD")
mtext("1999-2008")
legend("topright", legend = c("Total emission per year", "Trend line"), 
        col = c("blue", "green"), lwd = 1)

## Copy the graph into the png file

dev.copy(png, "plot2.png")
dev.off()
