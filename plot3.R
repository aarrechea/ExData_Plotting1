setwd("/home/adrian/Dropbox/R/course-data-science-specialization/course-04-exploratory-data-analysis/week-01")
getwd()

install.packages("chron")

library(lubridate)
library(dplyr)
library(chron)


#--------------------------------------------------------------------------------------------------
#                                   Load the dataset
#--------------------------------------------------------------------------------------------------
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "consumption.zip")
data <- read.table(unz("consumption.zip", "household_power_consumption.txt"), header = TRUE, sep=";")



#--------------------------------------------------------------------------------------------------
#     I use the function filter from dplyr library to filter the dates                                   
#--------------------------------------------------------------------------------------------------
data$Date <- as.Date(data$Date, "%d/%m/%Y") # convert the first variable to Date type
dataFilter <- data %>%
      filter(data$Date >= "2007/02/01" & data$Date <= "2007/02/02")
str(dataFilter)



#--------------------------------------------------------------------------------------------------
#     I use the function times of the chron library to transform factors in time                                   
#--------------------------------------------------------------------------------------------------
dataFilter$Time <- chron(times = as.character(dataFilter$Time))
str(dataFilter)



#--------------------------------------------------------------------------------------------------
#                                         Third graphic
# I have to change the type of the variables from factors to numeric.
# The variable "sub_metering_3" is already numeric
#--------------------------------------------------------------------------------------------------
dataFilter$Time <- strptime(paste(dataFilter$Date, dataFilter$Time), "%Y-%m-%d %H:%M:%S")
dataFilter$Sub_metering_1 <- as.numeric(as.character(dataFilter$Sub_metering_1))
dataFilter$Sub_metering_2 <- as.numeric(as.character(dataFilter$Sub_metering_2))

plot(dataFilter$Time, dataFilter$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(dataFilter$Time, dataFilter$Sub_metering_2, col = "red")
lines(dataFilter$Time, dataFilter$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

dev.copy(png,'plot3.png') # copying the plot to a png archive
dev.off() # close the device