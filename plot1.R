
## tell the read.table what to expect
columnNames = c("date", "time", "globalActivePower", "globalReactivePower", "voltage", "globalIntensity", "subMetering1", "subMetering2", "subMetering3")
columnTypes = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric" )

## load the data into a table
fileURL <- "household_power_consumption.txt"
df <- read.table(fileURL, header=TRUE, sep=";", col.names=columnNames, colClasses=columnTypes, na.strings="?")

## parse the dates
df$date = as.Date(df$date, format="%d/%m/%Y")

## filter according to our required date
df = df[df$date >= as.Date("2007-02-01") & df$date<=as.Date("2007-02-02"),]

## declare the output device
png(filename="plot1.png", width=480, height=480, units="px")

## draw the histogram
hist(df$globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## dump the output to the device
dev.off()