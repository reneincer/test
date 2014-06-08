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
png("plot2.png", width = 480, height = 480, units = "px", bg = "white")

plot(x=data$DateTime,y=as.numeric(data$Global_active_power),
     type="l",
     xlab="",
     ylab="Global Active Power (killowats)")

#closing device
dev.off()
