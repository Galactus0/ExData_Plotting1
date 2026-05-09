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

#initializing the plot
plot( time,data$Global_active_power, type = "l", ylab = "Global Active Power(kilowatts)"
      ,xlab = "",xaxt = "n")
ticks <- seq(from = floor_date(min(time), "day"), length.out = 3, by = "days")
axis(1, at = ticks, labels = c("Thu", "Fri", "Sat"))

#Saving the plot as png
dev.copy(png, file = "plot2.png")
dev.off()