# set the working directory
setwd('/nfs/science/raleys/donso/sandbox')

# read in full power data frame
power <- read.csv("/nfs/science/raleys/donso/sandbox/household_power_consumption.csv",
                  sep=" ",
                  stringsAsFactors=FALSE)

# look at the names of the data frame
names(power)

# look at  the structure of the data frame
str(power)

# narrow down to just the two dates we need
subpower <- power[ which(power$Date=='2/1/2007' | power$Date=='2/2/2007'), ]

# convert the date and time fields
subpower$Date <- as.Date(subpower$Date, format = "%m/%d/%Y")
subpower$datetime <- paste(as.Date(subpower$Date), subpower$Time)
subpower$datetime <- as.POSIXct(subpower$datetime)
subpower$Day <- weekdays(subpower$Date,abbreviate="TRUE")

# QA check on the date
table(subpower$Date)
table(subpower$Day)

# convert all the variables needed to numeric
subpower[, 3]  <- as.numeric(subpower[, 3])
subpower[, 4]  <- as.numeric(subpower[, 4])
subpower[, 5]  <- as.numeric(subpower[, 5])
subpower[, 6]  <- as.numeric(subpower[, 6])
subpower[, 7]  <- as.numeric(subpower[, 7])
subpower[, 8]  <- as.numeric(subpower[, 8])
subpower[, 9]  <- as.numeric(subpower[, 9])

# summary of the subpower data frame
summary(subpower)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

# plot 1 - histogram
hist(subpower$Global_active_power, 
     col = "red",
     breaks=16,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

# plot 2 - line graph
plot(subpower$Global_active_power ~ subpower$datetime,
     pch=".",
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

# plot 3 - sub-metering plots
with(subpower, {
  plot(Sub_metering_1 ~ datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ datetime, col = 'Red') # add the Sub_metering_2 line
  lines(Sub_metering_3 ~ datetime, col = 'Blue') # add the Sub_metering_3 line
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot 4 - all plots
plot(subpower$datetime, 
     subpower$Voltage,
     pch=".",
     type="l",
     ylab="Voltage",
     xlab="datetime")

dev.copy(png, file = "plot4.png") # output plot 4
dev.off()

