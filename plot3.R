
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
png(filename="plot3.png", width=480, height=480, units="px")

## draw the raw data
with(df, {
    # first the outer plot
    plot(subMetering1,type="n", xaxt="n", xlab="", ylab="Energy sub metering")
    
    # now the individual lines
    lines(x=subMetering1, col="black")
    lines(x=subMetering2, col="red")
    lines(x=subMetering3, col="blue")
})

## stick in the legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1), lwd=c(1,1))

## stick in our dates
axis(1, at=c(1, as.integer(nrow(df)/2), nrow(df)), labels=c("Thu", "Fri", "Sat"))

## dump the output to the device
dev.off()