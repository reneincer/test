#setwd("~/Documents/Data Science/Exploratory Data Analysis/Project01")
#This is faster but hardcoded
#data<-read.table("power.txt",skip=66637,nrows=2880,sep=";")
#colnames(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#this is dinamically

#data <- fread("power.txt", header=TRUE, na.strings="?",sep=";",)[Date == '1/2/2007' | Date == '2/2/2007']
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
png("plot1.png", width = 480, height = 480, units = "px", bg = "white")

#making histogram
hist(data$Global_active_power,
     xlab="Global Active Power (killowats)",
     main="Global Active Power",
     col="red")

#closing device
dev.off()
