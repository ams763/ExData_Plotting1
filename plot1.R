
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

##Plot histogram
png(filename = "plot1.png")
hist(df$Global_active_power, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()