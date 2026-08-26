# best subsets regression

# install packages if not previously installed
# install.packages("olsrr")

# active necessary library packages
library(olsrr)


# read in data file from working directory into a data frame
cravens_df <- read.csv("cravens_r.csv")
View(cravens_df)
str(cravens_df)

# estimate the full multiple linear regression model
cravens_mod <- lm(Sales~ ., data=cravens_df)

# estimate the best subsets linear regression model
ols_step_best_subset(cravens_mod, progress = TRUE, details = FALSE)
