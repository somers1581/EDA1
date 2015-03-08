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

# plot 2 - line graph
plot(subpower$Global_active_power ~ subpower$datetime,
     pch=".",
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

dev.copy(png, file = "plot2.png") # output plot 2
dev.off()
