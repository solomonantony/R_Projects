# performing a moving average forecast

#install necessary packages if not previously installed
# install.packages("TTR")

# activate necessary libraries
library(TTR)

# read in data file from working directory into a data frame
gasoline_df <- read.csv("gasoline_r.csv")
View(gasoline_df)

# create a vector of gasoline sales
gasoline_sales <- gasoline_df$Sales

# perform a three-week moving average
gas_ma3 <- SMA(gasoline_sales, n=3)
print(gas_ma3)