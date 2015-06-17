#Set Working Directory
setwd("D:\\DataScience\\Exploratory Data Analysis\\Course Project 2")

library(ggplot2)
url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'


#Download File and Unzip to the data folder
if (!file.exists('inputdata/exdata-data-NEI_data.zip')) {
  download.file(url, 'inputdata/exdata-data-NEI_data.zip')
  unzip('inputdata/exdata-data-NEI_data.zip', exdir='./inputdata')
}

EmissionsData <- readRDS('inputdata/summarySCC_PM25.rds')
sourceClassificationCode <- readRDS('inputdata/Source_Classification_Code.rds')

sources <- sourceClassificationCode[grepl("Coal", sourceClassificationCode$EI.Sector),]
sources <- sources$SCC
aggrdata <- EmissionsData[EmissionsData$SCC %in% sources,]
aggrdata <- aggregate(Emissions ~ year, data=aggrdata, sum)

plot <- qplot(year, Emissions, data=aggrdata, geom="path", main="Emission From Coal Combustion - Related Sources", xlab="Year", ylab="Emission")
ggsave(plot, file="plot4.png", width=7, height=5)

#Across the United States, how have emissions from coal combustion-related sources changed from 1999???2008?
# Emissions from coal combustion related sources have decreased by about 1/3 (from 6 Million to below 4 million) from 1999-2008