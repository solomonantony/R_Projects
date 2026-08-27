# stepwise regression


# install packages if not previously installed
# install.packages("olsrr")

# active necessary library packages
library(olsrr)


# read in data file from working directory into a data frame
cravens_df <- read.csv("cravens_r.csv")
View(cravens_df)

# estimate the full multiple linear regression model
cravens_mod <- lm(Sales~ ., data=cravens_df)

# estimate the stepwise linear regression model
ols_step_both_p(cravens_mod, pent=.05, prem=.05)