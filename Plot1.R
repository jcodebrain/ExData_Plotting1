## FILENAME - Plot1.R
    
## requires sqldf library
require("sqldf")
    
## defines local variables
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dirName <- "data"
zipName <- "data/household_power_consumption.zip"
fileName <- "data/household_power_consumption.txt"
mySQL <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## checks file
if (!file.exists(fileName)) {
    dir.create(dirName)   
    
    download.file(fileUrl, dest = zipName, method="curl")
    unzip(zipName, exdir=dirName)
    ##list.files(dirName)
}

## use read.csv2.sql function to read household power consumption data
myData <- read.csv2.sql(fileName,mySQL)
#head(fullData) # Check head data

## Set locale to ENGLISH 
Sys.setlocale("LC_TIME","C")

##### Plot 1 Start #####

## Save the plot to a PNG file
png(filename="plot1.png",width=480,height=480, units="px")
hist(myData$Global_active_power, col="red" , main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off() # This is a necessary call to close the png device

## Clean up ##
#file.remove(zipName)
#file.remove(fileName)
#file.remove(dirName)

##### Plot 1 End #####
    

    



