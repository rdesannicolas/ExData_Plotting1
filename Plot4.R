# Plot 4.R

# Reading the Datas and subsetting the Datas into a new file data.new which contains
# the datas from the 2 days, 2007-02-01 and 2007-02-02.
if (file.exists("household_power_consumption.txt")){
    data_origin <- read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE)
} else if (file.exists("exdata-data-household_power_consumption.zip")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    data_origin <- read.table(unz(fileUrl,"household_power_consumption.txt"), sep =";", header = TRUE, stringsAsFactors = FALSE)
} else {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "exdata-Fdata-Fhousehold_power_consumption.zip", method = "curl")
    data_origin <- read.table(unz("exdata-Fdata-Fhousehold_power_consumption.zip","household_power_consumption.txt"), sep =";", header = TRUE, stringsAsFactors = FALSE)
}

#data <- read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE)
#data$Date <- strptime(data$Date, format = "%d/%m/%Y")
#data.new <- subset(data, data$Date >= strptime("2007-02-01", format = "%Y-%m-%d") & data$Date <= strptime("2007-02-02", format = "%Y-%m-%d"))

# Transform the datas in order to be able to perform graphics plots
library(dplyr)
data_origin <- tbl_df(data_origin)
data_sub <- filter(data_origin, Date == "1/2/2007" | Date == "2/2/2007")
data_sub <- mutate(data_sub, Date_Time = paste(Date, Time, sep=" "))
data_sub$Date_Time <- strptime(data_sub$Date_Time, format = "%d/%m/%Y %H:%M:%S")
data_sub[,3:9] <- lapply(data_sub[,3:9], as.numeric)


# Plotting
par(mfrow=c(2,2))

plot(data_sub$Date_Time,data_sub$Global_active_power,xlab = "",ylab = "Global Active Power", type = "n", cex=.2)
lines(data_sub$Date_Time,data_sub$Global_active_power, type = "l")

plot(data_sub$Date_Time,data_sub$Voltage,xlab = "datetime",ylab = "Voltage", type = "n", cex=.2)
lines(data_sub$Date_Time,data_sub$Voltage, type = "l")

plot(data_sub$Date_Time,data_sub$Sub_metering_1,xlab = "",ylab = "Energy mub metering", type = "n", cex=.2)
lines(data_sub$Date_Time,data_sub$Sub_metering_1, type = "l")
lines(data_sub$Date_Time,data_sub$Sub_metering_2, col = "red", type = "l")
lines(data_sub$Date_Time,data_sub$Sub_metering_3, col = "blue", type = "l")
legend("topright", lty = c(1,1,1), legend = legtext, col = c("black", "red", "blue"), x.intersp = 0,y.intersp = .5, xjust = 0, yjust = 0, cex=.65, bty = "n")

plot(data_sub$Date_Time,data_sub$Global_reactive_power,xlab = "datetime",ylab = "Global Reactive Power", type = "n", cex=.2)
lines(data_sub$Date_Time,data_sub$Global_reactive_power, type = "l")

# Create PNG file
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))

plot(data_sub$Date_Time,data_sub$Global_active_power,xlab = "",ylab = "Global Active Power", type = "n", cex=.2)
lines(data_sub$Date_Time,data_sub$Global_active_power, type = "l")

plot(data_sub$Date_Time,data_sub$Voltage,xlab = "datetime",ylab = "Voltage", type = "n", cex=.2)
lines(data_sub$Date_Time,data_sub$Voltage, type = "l")

plot(data_sub$Date_Time,data_sub$Sub_metering_1,xlab = "",ylab = "Energy mub metering", type = "n", cex=.2)
lines(data_sub$Date_Time,data_sub$Sub_metering_1, type = "l")
lines(data_sub$Date_Time,data_sub$Sub_metering_2, col = "red", type = "l")
lines(data_sub$Date_Time,data_sub$Sub_metering_3, col = "blue", type = "l")
legend("topright", lty = c(1,1,1), legend = legtext, col = c("black", "red", "blue"), x.intersp = 0, xjust = 0, yjust = 0, cex=.65, bty = "n")

plot(data_sub$Date_Time,data_sub$Global_reactive_power,xlab = "datetime",ylab = "Global Reactive Power", type = "n", cex=.2)
lines(data_sub$Date_Time,data_sub$Global_reactive_power, type = "l")
dev.off()
