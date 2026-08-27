# performing a linear trend forecast

# read in data file from working directory into a data frame
bicycle_df <- read.csv("bicycle_r.csv")
View(bicycle_df)

# perform a linear regression for linear tend
bicycle_slr <- lm(Sales ~ Year, data = bicycle_df)
summary(bicycle_slr)