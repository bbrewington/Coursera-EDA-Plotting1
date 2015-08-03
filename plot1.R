## Coursera - Exploratory Data Analysis
## Course Project # 1
## Author: Brent Brewington, (github: bbrewington)
## Plot1.R

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

# Convert DF$Date to POSIXlt and save to new column called "Date_formatted"

Date_formatted <- strptime(DF$Date,"%d/%m/%Y")
DF <- cbind(DF, Date_formatted = Date_formatted)

# Create new data frame "DF_subset", which only includes Feb 1, 2007 - Feb 2, 2007

DF_subset <- subset(DF, Date_formatted == "2007-02-01" | Date_formatted == "2007-02-02")

# Create histogram and save to png file "plot1.png" in the working directory
png(file="plot1.png", width=480, height=480)
hist(DF_subset$Global_active_power, xaxp=c(0,6,3),yaxp=c(0,1200,6), main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
dev.off()