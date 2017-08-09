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

with(hpc_subset, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

dev.copy(png, file="plot2.png")
dev.off()