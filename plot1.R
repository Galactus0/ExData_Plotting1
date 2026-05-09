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

#initializing the plot
hist(as.numeric(data$Global_active_power), freq = TRUE, breaks = 12, col = "red",
     xlab = "Global Active Power(Kilowatts)", main = "Global Active Power")

#Saving the plot as png
dev.copy(png, file = "plot1.png")
dev.off()