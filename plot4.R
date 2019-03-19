library(sqldf)
library(dplyr)

if(!exists("readData")) {
  readData <- read.csv.sql("household_power_consumption.txt", header = TRUE, stringsAsFactors=F,sep = ";", sql = "select * from file where Date == '1/2/2007' or Date == '2/2/2007'")
}

readData$Date <- as.Date(readData$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(readData$Date), readData$Time)
readData$DateTime <- as.POSIXct(datetime)

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

plot(readData$Global_active_power~readData$DateTime, type = "l", xlab = "", ylab="Global Active Power (Kilowatts)")

plot(readData$Voltage~readData$DateTime, type = "l", xlab = "datetime", ylab="Voltage")

plot(readData$Sub_metering_1~readData$DateTime, col="black", type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(readData$Sub_metering_2~readData$DateTime, col="red", type = "l")
lines(readData$Sub_metering_3~readData$DateTime, col="blue", type = "l")
legend(x = "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(readData$Global_reactive_power~readData$DateTime, type = "l", xlab = "datetime")

dev.off()