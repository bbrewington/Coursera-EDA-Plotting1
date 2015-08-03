## Coursera - Exploratory Data Analysis
## Course Project # 1
## Author: Brent Brewington, (github: bbrewington)
## Plot3.R

# Get data from file "household_power_consumption", and save to data frame "DF"

if(!("household_power_consumption.txt" %in% list.files())){
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  DF <- read.table(unz(temp, "household_power_consumption.txt"), 
                   header=TRUE,sep=";",na.strings="?",stringsAsFactors=FALSE)
  unlink(temp)
} else{
  DF <- read.table("household_power_consumption.txt", 
                   header=TRUE,sep=";",na.strings="?",stringsAsFactors=FALSE)
}

# Create new data frame "DF_subset", which only includes Feb 1, 2007 - Feb 2, 2007

DF_subset <- subset(DF, Date == "1/2/2007" | Date == "2/2/2007")

# Convert DF_subset$Date to POSIXct and save to new column called "DateTime"

DateTime <- as.POSIXct(paste(as.Date(DF_subset$Date,"%d/%m/%Y"), DF_subset$Time), format="%Y-%m-%d %H:%M:%S")
DF_subset <- cbind(DF_subset, DateTime = DateTime)

# Create line plot and save to png file "plot3.png" in the working directory
png(file="plot3.png", width=480, height=480)

with(DF_subset, plot(DateTime, Sub_metering_1, ylab="Energy sub metering", xlab="",type = "n"))
with(DF_subset, lines(DateTime, Sub_metering_1, col = "black"))
with(DF_subset, lines(DateTime, Sub_metering_2, col = "red"))
with(DF_subset, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))

dev.off()