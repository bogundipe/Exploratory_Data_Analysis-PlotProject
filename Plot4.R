# download file from web

if(!file.exists("./Powerdata.zip")){dir.create("./Powerdata.zip")}
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "Powerdata.zip", mode = "wb")
file.exists("Powerdata.zip")
unzip("Powerdata.zip", exdir = ".")

#reading file 
file <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

# verify file exist
dim(file)
View(file)
names(file)

library(dplyr)

# Set date format
file[,"Date"] <- as.Date(file[,"Date"],format = "%d/%m/%Y")

# select data range
rgdata <- subset(file,Date == "2007-02-01" | Date == "2007-02-02")

GlobActPower <- suppressWarnings(as.numeric(rgdata[,"Global_active_power"]))

datime <- strptime(paste(rgdata$Date,rgdata$Time,sep = " "), "%Y-%m-%d %H:%M:%S" )
sub1 <- as.numeric(rgdata[,"Sub_metering_1"])
sub2 <- as.numeric(rgdata[,"Sub_metering_2"])
sub3 <- as.numeric(rgdata[,"Sub_metering_3"])

GlobReaPower <- as.numeric(rgdata[,"Global_reactive_power"])
Vlt <- as.numeric(rgdata[,"Voltage"])

png("plot4.png",width = 480, height = 480)

par(mfrow = c(2,2))

# Plot 1
plot(datime,GlobActPower,type = "l",xlab = " ",ylab = "Global Active Power")

# Plot 2
plot(datime,Vlt,type = "l",xlab = "datetime",ylab = "Voltage")

#Plot 3
plot(datime,sub1,col = "black",type = "l", xlab = " ", ylab = "Energy sub metering")
lines(datime, sub2, col = "red")
lines(datime, sub3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c("black","red","blue"))

#Plot 4
plot(datime,GlobReaPower,type = "l",xlab = "datetime",ylab = "Global_reactive_power")
dev.off()



