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

#Plot 4
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")
par(mfrow=c(2, 2), mar=c(4,4,3,3))
plot(data1$DateTime, data1$Global_active_power, type="l", ylab = 'Global Active Power', xlab="")
plot(data1$DateTime, as.numeric(data1$Voltage) , type="l", ylab = 'Voltage', xlab="datetime")
plot(data1$DateTime, data1$Sub_metering_1, type="l", ylab = 'Energy sub metering', xlab="")
lines(data1$DateTime, data1$Sub_metering_2, type = "l", col="red")
lines(data1$DateTime, data1$Sub_metering_3, type = "l", col="blue")
legend('topright', lwd = 2,
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col = c('black', 'red', 'blue'), bty = 'n',
       cex = 0.8)
plot(data1$DateTime, as.numeric(data1$Global_reactive_power), type="l", ylab = 'Global_reactive_power', xlab="datetime")
dev.off()
