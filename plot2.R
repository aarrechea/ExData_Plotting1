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
#                                         Second graphic
#--------------------------------------------------------------------------------------------------
dev.set(2) # setting the device to the screen

dataFilter <- mutate(dataFilter, month = month(dataFilter$Date))
dataFilter <- mutate(dataFilter, day = weekdays(dataFilter$Date))
dataFilter$day <- as.factor(dataFilter$day)
str(dataFilter)

dataFilter$Time <- strptime(paste(dataFilter$Date, dataFilter$Time), "%Y-%m-%d %H:%M:%S")

with(dataFilter, plot(Time, Global_active_power, type = "l"))

dev.copy(png,'plot2.png') # copying the plot to a png archive
dev.off() # close the device