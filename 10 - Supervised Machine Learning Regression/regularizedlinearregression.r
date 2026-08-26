
# uncomment next line and execute if package not installed yet
# install.packages("caret")
# install.packages("glmnet")

# load necessary libraries
library(caret)
library(glmnet)

# read in file from working directory
df<- read.csv("carseatsales_r.csv")

# review encoding of variables
# input variables need to be numerically encoded
str(df)

# create dummy binary variables for all categorical variables
df_dummy<- dummyVars(" ~ .", data = df, fullRank = TRUE)
df_dummy <- data.frame(predict(df_dummy, newdata = df))
df <- df_dummy

# set random number seed for randomized partition
# different seed values will generate different partitions of the data
set.seed(1975)

# use the createDataPartition to randomly select observations to be placed in the training set
# specify the target variable (y)
# set the percentage of data to set aside for training (p)
indxTrain <- createDataPartition(y = df$Sales, p=0.8, list=FALSE)

# define training set for cross-validation
training <- df[indxTrain,]

# define test set 
testing <- df[-indxTrain,]

# specify model training process
# method = k-fold cross-validation 
# number = number of folds
ctrl <- trainControl(method = "cv", number = 10)

# create a grid of parameter values to assess in k-fold cross-validation
# for regularized linear regression, two parameters: alpha and lambda
# alpha parameter controls the mix between ridge regularization and lasso regularization
# alpha = 0 -> ridge, alpha = 1 -> lasso
# lambda corresponds to the regularization penalty that dampens the size of the coefficients
grid <-expand.grid(.alpha=0:1, .lambda = seq(0, 1, length = 100))

# train model via 10-fold cross-validation
# first argument identifies y variable (before the ~) and the set of x variables (after the ~)
# note we are excluding the Store index variable 
# and variables serving as base for binary encoded categoricals
# second argument (data) specifies training set 
# third argument (method) specifies prediction method (regularized linear regression)
# fourth argument (trControl) specifies training process (cross-validation)
# fifth argument (tuneGrid) specifies the values of the parameters alpha and lambda
# sixth argument (preProcess) specifies that we need to center and scale variables
linregFit <- train(Sales ~ . - Store, data = training, method = "glmnet",
                trControl = ctrl, tuneGrid = grid, preProcess = c("center","scale"))


# identify values of alpha and lambda that minimizes the RMSE in the 10-fold cross-validation
linregFit

# output the regularized linear regression coefficients
coef(linregFit$finalModel, linregFit$bestTune$lambda)

# evaluating linear regression performance on testing set
linregPredict <- predict(linregFit,newdata = testing)

# output performance metrics
postResample(linregPredict, testing$Sales)

# create a data frame with the linregFit regression estimates and test set observations 
# write this data frame to a csv file
df_test <- cbind(linregPredict, testing$Sales)
write.csv(df_test, "linearregression_predictions.csv")

