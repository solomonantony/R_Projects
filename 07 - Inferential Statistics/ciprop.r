# finding the confidence interval for the population proportion

# read in data file from working directory into a data frame
tee_times_df <- read.csv("TeeTimes.csv")
View(tee_times_df)

# find the sample size
samp_size <- nrow(tee_times_df)

# create a data frame consisting only of the Yes responses
yesses <- subset(tee_times_df,Response=="Yes")

# count the number of Yes responses
yes_count <- nrow(yesses)

# calculate the sample proportion of Yes responses
p_bar <- yes_count/samp_size

# find the margin of error
error <- qnorm(0.975,0,1)*sqrt(p_bar*(1-p_bar)/samp_size)

# calculate the lower and upper limits of the confidence interval for the proportion
lower_lim <- p_bar - error
upper_lim <- p_bar + error
list(lower_lim,upper_lim)
