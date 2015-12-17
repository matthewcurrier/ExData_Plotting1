download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")

df <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, na.strings = "?")

df[, "Date"] <- as.Date(df$Date, "%d/%m/%Y")

dates <- c("02/01/2007", "02/02/2007")
dates <- as.Date(dates, "%m/%d/%Y")



to_keep <- df$Date %in% dates
df <- df[to_keep, ]

df[, "dates_concat"] <- paste(df$Date, df$Time)

df[, "date_time"] <- as.POSIXct(strptime(df$dates_concat, "%Y-%m-%d %H:%M:%S"))

result <- plot(df$date_time, df$Global_active_power, 
               type = "l", 
               lwd=1,
               ylab = "Global Active Power (Kilowatts)",
               xlab = "")

dev.print(png, file = "plot2.png", width = 480, height = 490)
dev.off()