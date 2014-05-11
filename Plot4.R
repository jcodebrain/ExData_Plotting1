## FILENAME - Plot4.R

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

## Create new variable
myData$DateTime <- as.POSIXct(paste(myData$Date,myData$Time),format='%d/%m/%Y %H:%M:%S')
# head(myData)

## Set locale to ENGLISH 
Sys.setlocale("LC_TIME","C")

##### Plot 4 Start #####

## Open png device
png(filename = "Plot4.png", width = 480, height = 480, units = "px")

## Create plot 
par(mfrow = c(2, 2))
with(myData, {
    plot(DateTime,as.numeric(Global_active_power),
         type = "l",
         main = "", 
         ylab = "Global Active Power (kilowatts)",
         xlab = "")
    plot(DateTime,as.numeric(Voltage),
         type = "l",
         main = "", 
         ylab = "Voltage",
         xlab = "datetime")
    plot(DateTime, Sub_metering_1,
         type = "l",
         main = "", 
         ylab = "Energy sub metering",
         xlab = "")
    lines(DateTime, Sub_metering_2,col="red")
    lines(DateTime, Sub_metering_3,col="blue")
    legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
           lty = c(1,1), 
           col=c("black","red","blue"),
           bty = "n")
    plot(DateTime,as.numeric(Global_reactive_power),
         type = "l",
         main = "", 
         ylab = "Global_reactive_power",
         xlab = "datetime")
})

dev.off() # This is a necessary call to close the png device

##### Plot 4 End #####
