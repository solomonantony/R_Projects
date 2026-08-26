# Chapter 8 backwardselection

# backwARD selection regression

# install packages if not previously installed
# install.packages("olsrr")

# active necessary library packages
library(olsrr)


# read in data file from working directory into a data frame
cravens_df <- read.csv("Cravens_r.csv")
View(cravens_df)

# estimate the full multiple linear regression model
cravens_mod <- lm(Sales~ ., data=cravens_df)

# estimate the backward selection linear regression model
ols_step_backward_p(cravens_mod, prem = .05)