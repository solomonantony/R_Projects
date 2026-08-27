
# finding confidence intervals for the population mean when population standard deviation is unknown

# read in data file from working directory into a data frame
new_balance_df <- read.csv("newbalance_r.csv")
View(new_balance_df)

# find the sample size
samp_size <- nrow(new_balance_df)

# create a vector of amount spent
balance <- new_balance_df$NewBalance

# find the margin of error
error <- qt(0.975,samp_size-1,lower.tail=TRUE)*sd(balance)/sqrt(samp_size)

# calculate the lower and upper limits of the confidence interval for the mean
lower_lim <- mean(balance) - error
upper_lim <- mean(balance) + error
list(lower_lim,upper_lim)