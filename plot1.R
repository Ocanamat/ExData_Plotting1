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

png("plot1.png")
hist(ePowerConsum_dataSet$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()