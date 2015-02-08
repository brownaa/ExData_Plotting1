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

dat$Global_active_power <- as.numeric(dat$Global_active_power)

hist(dat$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

png(filename = "plot1.png")
hist(dat$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
