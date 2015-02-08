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

dat$Global_active_power <- as.numeric(dat$Global_active_power)

## Plot
plot(dat$DateTime, dat$Global_active_power, type = 'l',
     xlab = '', ylab = 'Global Active Power (kilowatts)')

png(filename = "plot2.png")
plot(dat$DateTime, dat$Global_active_power, type = 'l',
     xlab = '', ylab = 'Global Active Power (kilowatts)')
dev.off()
