options(stringsAsFactors = FALSE)

if(!file.exists( "./data/household_power_consumption.zip")){
      if(!file.exists("./data")){
            dir.create("data")
      }
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(url = fileURL, destfile = "./data/household_power_consumption.zip")
      unzip("./data/household_power_consumption.zip", exdir = "./data")
}

dat <- read.csv2(file = "./data/household_power_consumption.txt")

## Subset by dates
dat <- subset(dat, as.Date(dat$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01"))
dat <- subset(dat, as.Date(dat$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"))

## make the Date & Time columns into one as.Date column
dat$DateTime <- paste(dat$Date, dat$Time)
dat$DateTime <- strptime(dat$DateTime, format = "%d/%m/%Y %H:%M:%S")
dat$Date <- NULL
dat$Time <- NULL

dat$Sub_metering_1            <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2            <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3            <- as.numeric(dat$Sub_metering_3)
dat$Global_active_power       <- as.numeric(dat$Global_active_power)
dat$Voltage                   <- as.numeric(dat$Voltage)
dat$Global_reactive_power     <- as.numeric(dat$Global_reactive_power)

## Plot
par(mfrow = c(2, 2))

#Gloabl Active Power Plot
plot(dat$DateTime, dat$Global_active_power, type = 'l',
     xlab = '', ylab = 'Global Active Power')

#Voltage Plot
plot(dat$DateTime, dat$Voltage, type = 'l',
     xlab = 'datetime', ylab = 'Voltage')

#Energy Sub Metering Plot
plot(dat$DateTime, dat$Sub_metering_1, type = 'l',
     xlab = '', ylab = 'Energy sub metering')
lines(dat$DateTime, dat$Sub_metering_2, type = 'l', col = 'red')
lines(dat$DateTime, dat$Sub_metering_3, type = 'l', col = 'blue')
legend(x = 'topright', 1.9, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', 'red', 'blue'),
       lty = c(1,1,1), bty = 'n')

#Global Reactive Power
plot(dat$DateTime, dat$Global_reactive_power, type = 'l',
     xlab = 'datetime', ylab = 'Global_reactive_power')

png(filename = "plot4.png")
par(mfrow = c(2, 2))

#Gloabl Active Power Plot
plot(dat$DateTime, dat$Global_active_power, type = 'l',
     xlab = '', ylab = 'Global Active Power')

#Voltage Plot
plot(dat$DateTime, dat$Voltage, type = 'l',
     xlab = 'datetime', ylab = 'Voltage')

#Energy Sub Metering Plot
plot(dat$DateTime, dat$Sub_metering_1, type = 'l',
     xlab = '', ylab = 'Energy sub metering')
lines(dat$DateTime, dat$Sub_metering_2, type = 'l', col = 'red')
lines(dat$DateTime, dat$Sub_metering_3, type = 'l', col = 'blue')
legend(x = 'topright', 1.9, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', 'red', 'blue'),
       lty = c(1,1,1), bty = 'n')

#Global Reactive Power
plot(dat$DateTime, dat$Global_reactive_power, type = 'l',
     xlab = 'datetime', ylab = 'Global_reactive_power')
dev.off()
