library(data.table)

#Get directory
getwd()
setwd("C:/Users/Core i5/Desktop/Coursera/Data science/Course 4_ Exploratory Data Analysis")
getwd()

#Loading the data
dataFile <- "./Project 1/household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

#Remove data to save memory, just leave the subSetData
rm(data)

#Transforming Date and Time variables from characters to objects of type Date and POSIXlt alike
subSetData$Date <- as.Date(subSetData$Date, format="%d/%m/%Y")
subSetData$Time <- strptime(subSetData$Time, format="%H:%M:%S")
subSetData[1:1440,"Time"] <- format(subSetData[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subSetData[1441:2880,"Time"] <- format(subSetData[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#Numeric values to write less code after
subSetData[, "Global_active_power"] <- as.numeric(subSetData$Global_active_power)
subSetData[, "Global_reactive_power"] <- as.numeric(subSetData$Global_reactive_power)
subSetData[, "Voltage"] <- as.numeric(subSetData$Voltage)
subSetData[, "Global_intensity"] <- as.numeric(subSetData$Global_intensity)
subSetData[,"Sub_metering_1"] <- as.numeric(subSetData$Sub_metering_1)
subSetData[,"Sub_metering_2"] <- as.numeric(subSetData$Sub_metering_2)
subSetData[,"Sub_metering_3"] <- as.numeric(subSetData$Sub_metering_3)
#str(subSetData)

#Making Plot 3
png("plot3.png", width=480, height=480) #saving the plot in png format
plot(subSetData$Time,subSetData$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(subSetData$Time,subSetData$Sub_metering_1)
lines(subSetData$Time,subSetData$Sub_metering_2,col="red")
lines(subSetData$Time,subSetData$Sub_metering_3,col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main="Energy Sub_metering")
dev.off()
