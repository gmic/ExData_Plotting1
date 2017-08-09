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

hist(hpc_subset$Global_active_power, breaks=12, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.copy(png, file="plot1.png")
dev.off()