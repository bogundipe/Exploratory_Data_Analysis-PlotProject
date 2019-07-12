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

# select range of data
rgdata <- subset(data,Date == "2007-02-01" | Date == "2007-02-02")

# Date-time format
datime<-strptime(paste(rgdata$Date,rgdata$Time,sep = " "), "%Y-%m-%d %H:%M:%S" )

# Convert string to numeric format
sub1 <- as.numeric(rgdata[,"Sub_metering_1"])
sub2 <- as.numeric(rgdata[,"Sub_metering_2"])
sub3 <- as.numeric(rgdata[,"Sub_metering_3"])

# Make and save plot
png("plot3.png",width = 480, height = 480)
plot(datime,sub1,col = "black",type = "l", xlab = " ", ylab = "Energy sub metering")
lines(datime, sub2, col = "red")
lines(datime, sub3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c("black","red","blue"))
dev.off()