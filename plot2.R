## Script to create plot2.png
## This was created as part of Coursera Data Science Specialization
## Course: Exploratory Data Analysis, Course Project # 1
## Author: Brent Brewington

# Get data from file "household_power_consumption", and save to data frame "DF"

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
DF <- read.table(unz(temp, "household_power_consumption.txt"), 
                 header=TRUE,sep=";",na.strings="?",stringsAsFactors=FALSE)
unlink(temp)

# Create new data frame "DF_subset", which only includes Feb 1, 2007 - Feb 2, 2007

DF_subset <- subset(DF, Date == "1/2/2007" | Date == "2/2/2007")

# Convert DF_subset$Date to POSIXct and save to new column called "DateTime"

DateTime <- as.POSIXct(paste(as.Date(DF_subset$Date,"%d/%m/%Y"), DF_subset$Time), format="%Y-%m-%d %H:%M:%S")
DF_subset <- cbind(DF_subset, DateTime = DateTime)

# Create line plot and save to png file "plot2.png" in the working directory
png(file="plot2.png", width=480, height=480)
plot(DateTime,DF_subset$Global_active_power, type="n", 
     ylab = "Global Active Power (kilowatts)", xlab="")
lines(DateTime,DF_subset$Global_active_power)
dev.off()