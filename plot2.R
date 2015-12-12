#plot2.R
rawData <- read.csv("../data/household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)

#make sure the myDateTime field is in the right format
myDateTime <- as.POSIXct(paste(rawData$Date, rawData$Time), format="%d/%m/%Y %H:%M:%S")
rawData$Date <- strptime(rawData$Date, "%d/%m/%Y")
rawData <- cbind(rawData, myDateTime)

#need to filter / subset the data based on these dates
rawData <- subset(rawData, rawData$Date <= "2007-02-02")
rawData <- subset(rawData, rawData$Date >= "2007-02-01")

#this field needs to be numeric
rawData$Global_active_power <- as.numeric(rawData$Global_active_power)

png("plot2.png", width=480, height=480, units="px")
par(mar=c(5,5,5,5))
plot(rawData$myDateTime, rawData$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off() 



