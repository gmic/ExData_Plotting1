library(data.table)

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file <- "household_power_consumption.zip"
extract_file <- "household_power_consumption.txt"

startDate = as.Date("2007-02-01");
endDate = as.Date("2007-02-02");

if(!file.exists(extract_file)) {
  if(!file.exists(zip_file)) {
    download.file(file_url,destfile=zip_file,method="curl")
  }
  unzip(zip_file)
}

hpc <- fread(extract_file, sep=";", dec=".", na.strings = "?")
hpc_subset <- hpc[as.Date(hpc$Date, "%d/%m/%Y") >= startDate & as.Date(hpc$Date, "%d/%m/%Y") <= endDate]

hpc_subset$DateTime <- as.POSIXct(strptime(paste(hpc_subset$Date, hpc_subset$Time), "%d/%m/%Y %H:%M:%S"))

# par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
par(mfrow = c(2, 2))

with(hpc_subset, {
  plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power")

  plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage")

  plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(DateTime, Sub_metering_2, type="l", col="red")
  lines(DateTime, Sub_metering_3, type="l", col="blue")
  legend("top", bty="n", xjust=1, lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")
})

dev.copy(png, file="plot4.png")
dev.off()