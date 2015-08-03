## Coursera - Exploratory Data Analysis
## Course Project # 1
## Author: Brent Brewington, (github: bbrewington)
## Plot4.R

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

# Create line plot and save to png file "plot4.png" in the working directory
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
  #Add plot to row 1, col 1
  plot(DateTime,DF_subset$Global_active_power, type="n", 
     ylab = "Global Active Power", xlab="")
  lines(DateTime,DF_subset$Global_active_power)
  #Add plot to row 1, col 2
  plot(DateTime,DF_subset$Voltage,xlab="datetime",ylab="Voltage", yaxp=c(234,246,3),type="n")
  lines(DateTime,DF_subset$Voltage)
  axis(side=2, at = seq(234,246,2))
  #Add plot to row 2, col 1
  with(DF_subset, plot(DateTime, Sub_metering_1, ylab="Energy sub metering", xlab="",type = "n"))
  with(DF_subset, lines(DateTime, Sub_metering_1, col = "black"))
  with(DF_subset, lines(DateTime, Sub_metering_2, col = "red"))
  with(DF_subset, lines(DateTime, Sub_metering_3, col = "blue"))
  legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         lty=c(1,1,1), col=c("black","red","blue"), cex=.9, bty="n")
  #Add plot to row 2, col 2
  plot(DateTime,DF_subset$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power", yaxp=c(0.0,0.5,5),type="n")
  lines(DateTime,DF_subset$Global_reactive_power)

dev.off()