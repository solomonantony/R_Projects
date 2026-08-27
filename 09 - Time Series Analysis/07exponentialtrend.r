# performing an exponential trend forecast

# read in data file from working directory into a data frame
cholest_df <- read.csv("cholesterol_r.csv")
View(cholest_df)

# create a new variable that is the natural logarithm of Revenue
ln_revenue <- log(cholest_df$Revenue)

# perform a linear regression for exponential trend
cholest_slr <- lm(ln_revenue ~ Year, data = cholest_df)
summary(cholest_slr)