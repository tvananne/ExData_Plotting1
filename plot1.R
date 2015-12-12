
#plot1.R

#move up a directory, enter the data folder and read in the data:
rawData <- read.csv("../data/household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)

#columns need to be in the right date format
rawData$Date <- strptime(rawData$Date, "%d/%m/%Y") 

#need to filter / subset the data based on these dates
rawData <- subset(rawData, rawData$Date <= "2007-02-02")
rawData <- subset(rawData, rawData$Date >= "2007-02-01")

#this needs to be a numeric field
rawData$Global_active_power <- as.numeric(rawData$Global_active_power)


png("plot1.png", width=480, height=480, units="px")
par(mar=c(5,5,5,5))
hist(rawData$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off() 
