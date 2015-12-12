
#plot3.R
rawData <- read.csv("../data/household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)
#need the myDateTime to be in POSIXct format
myDateTime <- as.POSIXct(paste(rawData$Date, rawData$Time), format="%d/%m/%Y %H:%M:%S")
rawData$Date <- strptime(rawData$Date, "%d/%m/%Y")
rawData <- cbind(rawData, myDateTime)

#filter the dataset to only include items including and between these dates
rawData <- subset(rawData, rawData$Date <= "2007-02-02")
rawData <- subset(rawData, rawData$Date >= "2007-02-01")

rawData$Sub_metering_1 <- as.numeric(rawData$Sub_metering_1)
rawData$Sub_metering_2 <- as.numeric(rawData$Sub_metering_2)
rawData$Sub_metering_3 <- as.numeric(rawData$Sub_metering_3)


#set up the plotting area
png("plot3.png", width=480, height=480, units="px")
par(mar=c(5,5,5,5))

#draw the actual graph to graphics device
plot(rawData$myDateTime, rawData$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(rawData$myDateTime, rawData$Sub_metering_2, col = "red")
lines(rawData$myDateTime, rawData$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1), cex = .76)

dev.off() 
