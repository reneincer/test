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
png("plot3.png", width = 480, height = 480, units = "px", bg = "white")

par(mfrow = c(1, 1))
#Creating plot with 3 sub metering and anotations
with(data,{ 
        plot(DateTime, as.numeric(Sub_metering_1), type = "l", ylab="Energy sub metering")
        points(DateTime, as.numeric(Sub_metering_2), type = "l", col = "red")
        points(DateTime, as.numeric(Sub_metering_3), type = "l", col = "blue")
        legend("topright", lty = c(1,1,1), 
               col = c("black", "red", "blue"), 
               legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
})

#closing device
dev.off()
