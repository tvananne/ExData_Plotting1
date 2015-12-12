
#plot4.R - 4-panel-combo chart

#read in the raw data:
rawData <- read.csv("../data/household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)
#create a new date field for subsetting purposes
myDateTime <- as.POSIXct(paste(rawData$Date, rawData$Time), format="%d/%m/%Y %H:%M:%S")
rawData$Date <- strptime(rawData$Date, "%d/%m/%Y") 
rawData <- cbind(rawData, myDateTime)
rm(myDateTime)

rawData <- subset(rawData, rawData$Date <= "2007-02-02")
rawData <- subset(rawData, rawData$Date >= "2007-02-01")
#make all of these variables numeric
rawData$Global_active_power <- as.numeric(rawData$Global_active_power)
rawData$Global_reactive_power <- as.numeric(rawData$Global_reactive_power)
rawData$Sub_metering_1 <- as.numeric(rawData$Sub_metering_1)
rawData$Sub_metering_2 <- as.numeric(rawData$Sub_metering_2)
rawData$Sub_metering_3 <- as.numeric(rawData$Sub_metering_3)
rawData$Voltage <- as.numeric(rawData$Voltage)


#set up the graphics device for the plot
png("plot4.png", width=480, height=480, units="px")
par(mfrow = c(2, 2), mar = c(5,4.5,3,3))
# first plot *****************************************

plot(rawData$myDateTime, rawData$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

# second plot ****************************************

plot(rawData$myDateTime, rawData$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")

# third plot ****************************************

plot(rawData$myDateTime, rawData$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(rawData$myDateTime, rawData$Sub_metering_2, col = "red")
lines(rawData$myDateTime, rawData$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1), cex = .9)

# fourth plot *****************************************

plot(rawData$myDateTime, rawData$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off() 
