# Plot 2.R

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
par(mfrow=c(1,1))
plot(data_sub$Date_Time,data_sub$Global_active_power,xlab = "",ylab = "Global Active Power (kilowatts)", type = "n")
lines(data_sub$Date_Time,data_sub$Global_active_power, type = "l")

# Create PNG file
png(filename = "plot2.png", width = 480, height = 480, units = "px")
par(mfrow=c(1,1))
plot(data_sub$Date_Time,data_sub$Global_active_power,xlab = "",ylab = "Global Active Power (kilowatts)", type = "n")
lines(data_sub$Date_Time,data_sub$Global_active_power, type = "l")
dev.off()
