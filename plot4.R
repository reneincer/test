#install.packages("sqldf")

#Adding Library sqldf
library(sqldf)
#Dates has to be with quotes ' 
dateIni <- "'1/2/2007'"
dateEnd <- "'2/2/2007'"
#using paste to join strings to get on SQL string
sqlstring <- paste("select * from file where Date = ",dateIni, " OR DATE = ",dateEnd)
#reading data with sql to data
data <- read.csv.sql(file="household_power_consumption.txt",sep=";",header= TRUE, sql = sqlstring)

#creating new column DateTime and adding to my frame
data <- cbind(data,strptime(x=paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S"))

#setting colname tu new column, this column could be useful for other plots
colnames(data)[10] <- "DateTime"

#Creating Device for output
png("plot4.png", width = 600, height = 600, units = "px", bg = "white")

#2x2 matrix's plot
par(mfrow = c(2, 2))

with(data,{
        #Plot Global Active Power
        plot(x=data$DateTime,y=as.numeric(data$Global_active_power),
             type="l",
             xlab="",
             ylab="Global Active Power")
        #Plot Voltage
        plot(x=data$DateTime,y=as.numeric(data$Voltage),
             type="l",
             xlab="Datetime",
             ylab="Voltage")
        #Plot Sub Metering
        plot(DateTime, as.numeric(Sub_metering_1), type = "l", 
             xlab="", 
             ylab="Energy sub metering")
        points(DateTime, as.numeric(Sub_metering_2), type = "l", col = "red")
        points(DateTime, as.numeric(Sub_metering_3), type = "l", col = "blue")
        legend("topright", lty = c(1,1,1), cex=1.0, 
               col = c("black", "red", "blue"), 
               legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
        #Plot Global reacrive power
        plot(x=data$DateTime,y=as.numeric(data$Global_reactive_power),
             type="l",
             xlab="Datetime", 
             ylab="Global Reactive Power")
})

#closing device
dev.off()