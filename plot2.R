library(sqldf)
library(dplyr)

if(!exists("readData")) {
  readData <- read.csv.sql("household_power_consumption.txt", header = TRUE, stringsAsFactors=F,sep = ";", sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'")
}

readData$Date <- as.Date(readData$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(readData$Date), readData$Time)
readData$DateTime <- as.POSIXct(datetime)

png("plot2.png", width = 480, height = 480)
plot(readData$Global_active_power~readData$DateTime, type = "l", xlab = "", ylab="Global Active Power (Kilowatts)")
dev.off()