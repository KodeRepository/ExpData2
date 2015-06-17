#Set Working Directory
setwd("D:\\DataScience\\Exploratory Data Analysis\\Course Project 2")
url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

#Download File and Unzip to the data folder
if (!file.exists('inputdata/exdata-data-NEI_data.zip')) {
  download.file(url, 'inputdata/exdata-data-NEI_data.zip')
  unzip('inputdata/exdata-data-NEI_data.zip', exdir='./inputdata')
}

EmissionData <- readRDS('inputdata/summarySCC_PM25.rds')
#srcClassificationCode <- readRDS('data/Source_Classification_Code.rds')

png('plot2.png', width = 480, height = 480)
aggrdata <- aggregate(Emissions ~ year, data=EmissionData, sum)

png('plot1.png', width = 480, height = 480)                                                                              
plot(aggrdata$year, aggrdata$Emissions, type="b", main="Total Emission Per Year", xlab="Year", ylab="Total Emission")
dev.off()