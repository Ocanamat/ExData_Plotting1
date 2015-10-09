library(data.table)

classes                 <- c("character", "character", 
                             "numeric", "numeric", "numeric", "numeric", 
                             "numeric", "numeric", "numeric")

ePowerConsum_dataSet    <- fread("./household_power_consumption.txt", 
                                 header = TRUE, 
                                 sep = ";", 
                                 na.strings = c("NA", "-", "?"), 
                                 stringsAsFactors = FALSE, 
                                 colClasses = classes)

selected.dates_Indices  <- grep("^[1-2]/2/2007" , ePowerConsum_dataSet$Date)

ePowerConsum_dataSet    <- ePowerConsum_dataSet[selected.dates_Indices,]
#ePowerConsum_dataSet$Date <- as.Date(ePowerConsum_dataSet$Date, format = "%d/%m/%Y")

character_date.Time <- paste(ePowerConsum_dataSet$Date, ePowerConsum_dataSet$Time)
date.Time <- as.POSIXct(strptime(character_date.Time, format = "%d/%m/%Y %H:%M:%S"))
ePowerConsum_dataSet <- cbind(date.Time, ePowerConsum_dataSet)

png("plot4.png")
par(mfrow=c(2,2))
plot(ePowerConsum_dataSet$date.Time, 
     ePowerConsum_dataSet$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power", 
     xlab = "")
plot(ePowerConsum_dataSet$date.Time, 
     ePowerConsum_dataSet$Voltage, 
     type = "l", 
     ylab = "Voltage", 
     xlab = "datetime")
plot(ePowerConsum_dataSet$date.Time, 
     ePowerConsum_dataSet$Sub_metering_1 , 
     type = "l", 
     ylab = "Energy sub metering", 
     xlab = "")
lines(ePowerConsum_dataSet$date.Time, 
      ePowerConsum_dataSet$Sub_metering_2 , 
      type = "l", 
      xlab = "", 
      col = "red" )
lines(ePowerConsum_dataSet$date.Time, 
      ePowerConsum_dataSet$Sub_metering_3 , 
      type = "l", 
      xlab = "", 
      col = "blue" )
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=c(2.5,2.5, 2.5),
       col = c("black", "red", "blue"), 
       bty = "n")
plot(ePowerConsum_dataSet$date.Time, 
     ePowerConsum_dataSet$Global_reactive_power, 
     type = "l", 
     ylab = "Global Reactive Power", 
     xlab = "datetime")
dev.off()