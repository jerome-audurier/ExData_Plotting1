#
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"

# download data
if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
}

# unzip zip file containing data if nedded
dataPath <- "household_power_consumption.txt"
if (!file.exists(dataPath)) {
    unzip(zipFile)
}

# read data
hpc <- read.csv(dataPath, sep = ";")
# subset data
hpc_data <- hpc[hpc$Date %in% c('1/2/2007','2/2/2007'), ]

# format data
datetime <- strptime(paste(hpc_data$Date, hpc_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(as.character(hpc_data$Global_active_power))
subMetering1 <- as.numeric(as.character(hpc_data$Sub_metering_1))
subMetering2 <- as.numeric(as.character(hpc_data$Sub_metering_2))
subMetering3 <- as.numeric(as.character(hpc_data$Sub_metering_3))
voltage <- as.numeric(as.character(hpc_data$Voltage))
globalReactivePower <- as.numeric(as.character(hpc_data$Global_reactive_power))

# build plot
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power")

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col=c("black", "red", "blue"), bty="n", cex=0.5)

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

# save plot
dev.copy(png, "plot4.png", width=480, height=480)
dev.off()
