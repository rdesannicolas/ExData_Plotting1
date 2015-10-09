# Plot 4.R

# Reading the Datas
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data_origin <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header = TRUE, stringsAsFactors = FALSE)
unlink(temp)

# Transform the datas in order to be able to perform graphics plots
data_sub <- subset(data_origin, data_origin$Date == "1/2/2007" | data_origin$Date == "2/2/2007")
dt <- paste(data_sub$Date, data_sub$Time, sep=" ")
dt <- strptime(dt, format = "%d/%m/%Y %H:%M:%S")
data_sub$Date_Time <- dt
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
legtext = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", lty = c(1,1,1), legend = legtext, col = c("black", "red", "blue"), yjust = 0, y.intersp = .4, cex=.65, bty = "n")

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
legtext = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", lty = c(1,1,1), legend = legtext, col = c("black", "red", "blue"), cex=1, bty = "n")

plot(data_sub$Date_Time,data_sub$Global_reactive_power,xlab = "datetime",ylab = "Global Reactive Power", type = "n", cex=.2)
lines(data_sub$Date_Time,data_sub$Global_reactive_power, type = "l")
dev.off()
