
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
png(filename="plot2.png", width=480, height=480, units="px")

## draw the line plot
plot(df$globalActivePower, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
axis(1, at=c(1, as.integer(nrow(df)/2), nrow(df)), labels=c("Thu", "Fri", "Sat"))

## dump the output to the device
dev.off()