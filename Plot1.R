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

# select range of analysis/plot
rgdata <- subset(file,Date == "2007-02-01" | Date == "2007-02-02")

View(rgdata)

# Convert string to numeric format
GlobActPower <- suppressWarnings(as.numeric(rgdata[,"Global_active_power"]))

# Make and save plot
png("plot1.png",width = 480, height = 480)
hist(GlobActPower, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
