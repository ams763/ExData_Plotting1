
library(dplyr)

##Read in data (rough subset)
filename <- "household_power_consumption.txt"
df <- read.table(filename, 
                 header = TRUE, 
                 sep = ";", 
                 skip = 65000, 
                 nrows=5000, 
                 stringsAsFactors = FALSE,
                 na.strings = "?")
names(df) <- names(read.table(filename, 
                              sep = ";", 
                              header = TRUE, 
                              nrows = 1))

##Filter dataset for February 1 and 2, 2007
df <- mutate(df, "DateTime" = paste(Date, Time))
df$DateTime <- strptime(df$DateTime,
                        format = "%d/%m/%Y %H:%M:%S")
df <- df["2007-02-01" <= df$DateTime & df$DateTime < "2007-02-03", ]

##Plot multivariate line chart
png(filename = "plot3.png")


with(df, plot(DateTime, Sub_metering_1, 
              type = "l", 
              ylab = "Energy sub metering", 
              xlab = "",
              col = "black"))
with(df, points(DateTime, Sub_metering_2, col = "red", type = "l"))
with(df, points(DateTime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", 
       lwd = 1,
       col = c("black", "red", "blue"), 
       legend = names(df)[7:9])
dev.off()