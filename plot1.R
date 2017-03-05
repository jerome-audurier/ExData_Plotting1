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
globalActivePower <- as.numeric(as.character(hpc_data$Global_active_power))
# build plot
hist(globalActivePower, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# save plpt
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()
