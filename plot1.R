library(dplyr)
Sys.setlocale("LC_TIME", "C")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" , destfile ="./data.zip", method = "curl")
file<-unzip(zipfile = "data.zip")
data <- read.table(file, sep = ";", header=T)

head(data)
data[data=="?"]<-NA
x <- paste(data$Date, data$Time)
data$DateTime<-strptime(x, "%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date, format = "%d/%m/%Y")
data$Time <-strptime(data$Time, format = "%H:%M:%S")
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
data1<-filter(data, 
              Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))

#Plot 1
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")
hist(data1$Global_active_power, 
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     col = 'red')
dev.off()
