#Set Working Directoryl
ibrary(ggplot2)

url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

#Download File and Unzip to the data folder
if (!file.exists('data/exdata-data-NEI_data.zip')) {
  download.file(url, 'data/exdata-data-NEI_data.zip')
  unzip('data/exdata-data-NEI_data.zip', exdir='./data')
}

EmissionsData <- readRDS('data/summarySCC_PM25.rds')
sourceClassificationCode <- readRDS('data/Source_Classification_Code.rds')

sources <- sourceClassificationCode[grepl("On-Road", sourceClassificationCode$EI.Sector),]
sources <- sources$SCC
inpdata <- EmissionsData[EmissionsData$SCC %in% sources,]
inpdata <- EmissionsData[EmissionsData$fips %in% c("24510", "06037"),]
inpdata <- aggregate(Emissions ~ year + fips, data=inpdata, sum)

plot <- qplot(year, Emissions, color=fips, data=inpdata, geom="path", main="Emission From Vehicle Related Sources in Baltimore and Los Angeles County", xlab="Year", ylab="Emission")
ggsave(plot, file="plot6.png", width=10, height=5)

#Which city has seen greater changes over time in motor vehicle emissions?
#Los Angeles