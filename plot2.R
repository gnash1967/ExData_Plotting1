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

# plot graph
plot(data$DateTime, as.numeric(as.character(data$Global_active_power)),
     xlab= "", ylab = "Global Active Power (kilowatts)", type = "l", col = "black")

# print to .png then close
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
