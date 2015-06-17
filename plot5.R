#Set Working Directory
library(ggplot2)

url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

#Download File and Unzip to the data folder
if (!file.exists('inputdata/exdata-data-NEI_data.zip')) {
  download.file(url, 'inputdata/exdata-data-NEI_data.zip')
  unzip('inputdata/exdata-data-NEI_data.zip', exdir='./inputdata')
}

EmissionsData <- readRDS('inputdata/summarySCC_PM25.rds')
sourceClassificationCode <- readRDS('data/Source_Classification_Code.rds')

sources <- sourceClassificationCode[grepl("On-Road", sourceClassificationCode$EI.Sector),]
sources <- sources$SCC
inpdata <- EmissionsData[EmissionsData$SCC %in% sources,]
inpdata <- EmissionsData[EmissionsData$fips == "24510",]
inpdata <- aggregate(Emissions ~ year, data=inpdata, sum)

plot <- qplot(year, Emissions, data=inpdata, geom="path", main="Emissions From Vehicle Related Sources in Baltimore", xlab="Year", ylab="Emissions")
ggsave(plot, file="plot5.png", width=6, height=5)

#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#Emissions from motor vehicle sources have dropped from 1999-2008 in Baltimore City!