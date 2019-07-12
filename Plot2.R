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

# Date-time format
datime <- strptime(paste(rgdata$Date,rgdata$Time,sep = " "), "%Y-%m-%d %H:%M:%S" )
View(datime)

# Convert string to numeric format
GlobActPower <- as.numeric(rgdata[,"Global_active_power"])

# Make and save plot
png("plot2.png",width = 480, height = 480)
plot(datime,GlobActPower,type = "l",xlab = " ",ylab = "Global Active Power (kilowatts)")
dev.off()