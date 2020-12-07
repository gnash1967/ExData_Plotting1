# add libraries
library(lubridate)

# read data

data <- read.csv('./Data/household_power_consumption.txt', sep = ';', header = TRUE)

#combine date and time into datetime
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)
data$DateTime <- as_datetime(data$Date + data$Time)

#filter data based on date
data <-subset(data, Date>= as.Date("2007-02-01", format = "%Y-%m-%d") & Date 
              <= as.Date("2007-02-02"), format = "%Y-%m-%d")


#remove ? denoting NA
vars <- c("?", "NA")
data %>% drop_na(any_of(vars))

par(mfrow=c(2,2))

# top left
# plot histogram
plot(data$DateTime, as.numeric(as.character(data$Global_active_power)),
     xlab= "", ylab = "Global Active Power (kilowatts)", type = "l", col = "black")

# top right
plot(data$DateTime, as.numeric(as.character(data$Voltage)),
     xlab= "datetime", ylab = "Voltage", type = "l", col = "black")

# bottom left
# plot graph
plot(data$DateTime,as.numeric(as.character(data$Sub_metering_1)),
     xlab= "", ylab = "Energy sub metering", type = "l", col = "black")
# add lines
lines(data$DateTime,as.numeric(as.character(data$Sub_metering_2)),
      xlab= "", ylab = "Energy sub metering", type = "l", col = "red")
lines(data$DateTime,as.numeric(as.character(data$Sub_metering_3)),
      xlab= "", ylab = "Energy sub metering", type = "l", col = "blue")
#op <- par(cex = 0.1)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red", "blue"), lwd = 1, cex = 0.15, bty="n")

# bottom right
plot(data$DateTime, as.numeric(as.character(data$Global_reactive_power)),
     xlab= "datetime", ylab = "Global_reactive_power", type = "l", col = "black")

# print to .png then close
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
