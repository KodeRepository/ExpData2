#Set Working Directory
setwd("D:\\DataScience\\Exploratory Data Analysis\\Course Project 2")

url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
library(ggplot2)
#Download File and Unzip to the data folder
if (!file.exists('inputdata/exdata-data-NEI_data.zip')) {
  download.file(url, 'inputdata/exdata-data-NEI_data.zip')
  unzip('inputdata/exdata-data-NEI_data.zip', exdir='./inputdata')
}

EmissionData <- readRDS("inputdata/summarySCC_PM25.rds")
SCC <- readRDS("inputdata/Source_Classification_Code.rds")

# Get subset of the dara for Baltimore Scity
subsetEmissionData <- EmissionData[EmissionData$fips=="24510", ]
aggregatedTotal<- aggregate(Emissions ~ year + type, subsetEmissionData, sum)


png("plot3.png", width=640, height=480)
g <- ggplot(aggregatedTotal, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emission")) +
  ggtitle('Total Emission in Baltimore City, Maryland from 1999 to 2008')
print(g)
#ggsave(plot, file="plot3.png", width=10, height=5)
dev.off()

# Which of these four sources have seen decreases in emissions from 1999???2008 for Baltimore City? 
# answer : nonpoints, nonraad, onroad

# Which have seen increases in emissions from 1999???2008? 
# answer : point
