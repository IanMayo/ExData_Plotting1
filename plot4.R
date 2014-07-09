
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
png(filename="plot4.png", width=480, height=480, units="px", bg="transparent")

## declare multi plot layout
par(mfrow=c(2,2))

## top left
### first the plot
plot(df$globalActivePower, type="l",xaxt="n",xlab="", ylab="Global Active Power")
### and the date axis
axis(1, at=c(1, as.integer(nrow(df)/2), nrow(df)), labels=c("Thu", "Fri", "Sat"))

## top right
### first the plot
plot(df$voltage, type="l",xaxt="n",xlab="datetime", ylab="Voltage")
### and the date axis
axis(1, at=c(1, as.integer(nrow(df)/2), nrow(df)), labels=c("Thu", "Fri", "Sat"))

## bottom left
### first the plot
with(df, {
    # first the outer plot
    plot(subMetering1,type="n", xaxt="n", xlab="", ylab="Energy sub metering")
    
    # now the individual lines
    lines(x=subMetering1, col="black")
    lines(x=subMetering2, col="red")
    lines(x=subMetering3, col="blue")
})

### and the date axis
axis(1, at=c(1, as.integer(nrow(df)/2), nrow(df)), labels=c("Thu", "Fri", "Sat"))

### lastly, stick in the legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1), lwd=c(1,1))


## bottom right
### first the plot
plot(df$globalReactivePower, type="l",xaxt="n",xlab="datetime", ylab="Global_reactive_power")

### and the date axis
axis(1, at=c(1, as.integer(nrow(df)/2), nrow(df)), labels=c("Thu", "Fri", "Sat"))

## dump the output to the device
dev.off()