# Plot 1.R

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

# Transform the datas in order to be able to perform graphics plots
library(dplyr)
data_origin <- tbl_df(data_origin)
data_sub <- filter(data_origin, Date == "1/2/2007" | Date == "2/2/2007")
data_sub <- mutate(data_sub, Date_Time = paste(Date, Time, sep=" "))
data_sub$Date_Time <- strptime(data_sub$Date_Time, format = "%d/%m/%Y %H:%M:%S")
data_sub[,3:9] <- lapply(data_sub[,3:9], as.numeric)


# Plotting
par(mfrow=c(1,1))
hist(data_sub$Global_active_power, xlab = "Global Active Power (kilowatts)",main = "Global Active Power", col="red")

# Create PNG file
png(filename = "plot1.png", width = 480, height = 480, units = "px")
par(mfrow=c(1,1))
hist(data_sub$Global_active_power, xlab = "Global Active Power (kilowatts)",main = "Global Active Power", col="red")
dev.off()

