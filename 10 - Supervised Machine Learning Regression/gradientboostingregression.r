# Fills a gap from Chapter 10: knn/neural net/random forest/tree/
# regularized regression are all covered, but gradient boosting - often
# the strongest of the tree-based methods in practice - is not.

# install.packages("caret")
# install.packages("xgboost")
library(caret)

df <- mtcars  # built-in dataset; predicting mpg from other car attributes

set.seed(1975)
indxTrain <- createDataPartition(y = df$mpg, p = 0.8, list = FALSE)
training <- df[indxTrain, ]
testing <- df[-indxTrain, ]

ctrl <- trainControl(method = "cv", number = 10)

# a small tuning grid for xgboost's key parameters:
# nrounds = number of boosting iterations (trees added sequentially)
# max_depth = depth of each individual tree
# eta = learning rate (how much each new tree corrects prior errors)
grid <- expand.grid(nrounds = c(50, 100), max_depth = c(2, 4),
                     eta = c(0.1, 0.3), gamma = 0, colsample_bytree = 1,
                     min_child_weight = 1, subsample = 1)

gbFit <- train(mpg ~ ., data = training, method = "xgbTree",
               trControl = ctrl, tuneGrid = grid, verbosity = 0)

gbFit
varImp(gbFit)

gbPredict <- predict(gbFit, newdata = testing)
postResample(gbPredict, testing$mpg)

# --- chart: predicted vs. actual - points on the diagonal line mean a
# perfect prediction, so this shows at a glance how well the model fits ---
plot(testing$mpg, gbPredict, pch = 16, col = "steelblue",
     xlab = "Actual mpg", ylab = "Predicted mpg",
     main = "Gradient Boosting: Predicted vs. Actual")
abline(0, 1, col = "red", lwd = 2, lty = 2)  # the "perfect prediction" reference line

# --- chart: variable importance, showing which predictors drove the model most ---
plot(varImp(gbFit), main = "Gradient Boosting: Variable Importance")
