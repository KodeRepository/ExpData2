#Set Working Directory
setwd("D:\\DataScience\\Exploratory Data Analysis\\Course Project 2")
url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'


#Download File and Unzip to the data folder
if (!file.exists('inputdata/exdata-data-NEI_data.zip')) {
  download.file(url, 'inputdata/exdata-data-NEI_data.zip')
  unzip('inputdata/exdata-data-NEI_data.zip', exdir='./data')
}

EmissionsData <- readRDS('inputdata/summarySCC_PM25.rds')
#sourceClassificationCode <- readRDS('data/Source_Classification_Code.rds')

aggrdata <- EmissionsData[EmissionsData$fips == "24510",]
aggrdata <- aggregate(Emissions ~ year, data=aggrdata, sum)

png('plot2.png', width = 480, height = 480)                                                                              
plot(aggrdata$year, aggrdata$Emissions, type="b", main="Total Emission Per Year in Baltimore", xlab="Year", ylab="Total Emission")
dev.off()