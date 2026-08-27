# performing an exponential smoothing forecast

#install necessary packages if not previously installed
# install.packages("TTR")

# activate necessary libraries
library(TTR)

# read in data file from working directory into a data frame
gasoline_df <- read.csv("gasoline_r.csv")
View(gasoline_df)

# create a vector of gasoline sales
gasoline_sales <- gasoline_df$Sales

# perform an exponential smoothing forecast
gas_ema.2 <- EMA(gasoline_sales, n=1, ratio = .2)
print(gas_ema.2)