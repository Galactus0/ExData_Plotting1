library(dplyr)
library(lubridate)
library(data.table)

# Getting only the date column
initial_data <- fread("household_power_consumption.txt", select = 1)
date <- dmy(initial_data[[1]])
# Extracting rows of only two days of February 
feb <- date == ymd("2007-02-01") | date == ymd("2007-02-02")

# Extracting data of only the corresponding columns to the date
data <- tibble(fread("household_power_consumption.txt"))
data <- filter(data, feb)
#combining date and time for the labeling of ticks
time <- dmy_hms(paste(data$Date,data$Time))
ticks <- seq(from = floor_date(min(time), "day"), length.out = 3, by = "days")
#Setting mfrow parameter so that four plots can be created on same device
par(mfrow = c(2,2))


#initializing first plot
plot( time,data$Global_active_power, type = "l", ylab = "Global Active Power(kilowatts)"
      ,xlab = "",xaxt = "n")
axis(1, at = ticks, labels = c("Thu", "Fri", "Sat"))

#initializing second plot

plot(time,data$Voltage, type = "l", xaxt = "n", ylab = "Voltage", xlab = "datetime")
axis(1, at = ticks, labels = c("Thu", "Fri", "Sat"))

#initializing third plot
plot( time,data$Sub_metering_1, type = "l",col = "black", ylab = "Global Active Power(kilowatts)"
      ,xlab = "",xaxt = "n")
lines(time, data$Sub_metering_2, col = "red")
lines(time, data$Sub_metering_3, col = "blue")
axis(1, at = ticks, labels = c("Thu", "Fri", "Sat"))

#initializing fourth plot
plot(time,data$Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime")
axis(1, at = ticks, labels = c("Thu", "Fri", "Sat"))

#Saving the plot as png
dev.copy(png, file = "plot4.png")
dev.off()
