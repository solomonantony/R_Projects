# testing a hypothesis about a population mean when population standard deviation is unknown

# read in data file from working directory into a data frame
coffee_df <- read.csv("coffee_r.csv")

# view the data in the data frame
View(coffee_df)
str(coffee_df)

# create a vector of weights
weights <- coffee_df$Weight

# perform the hypothesis test of the population mean when the population standard deviation is unknown
test <- t.test(weights, alternative="less",mu=3,conf.level=0.99)
list(test)
