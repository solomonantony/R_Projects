# uncomment next line and execute if package not installed yet
# install.packages("caret")
# install.packages("glmnet")
# install.packages("ROCR")

# load necessary libraries
library(caret)
library(glmnet)
library(ROCR)

# read in file from working directory
df<- read.csv("highsales_r.csv")

# review encoding of variables
# input variables need to be numerically encoded
str(df)

# create dummy binary variables for all categorical variables
df_dummy<- dummyVars("HighSales~ .", data = df, fullRank = TRUE)
df_dummy <- data.frame(predict(df_dummy, newdata = df))
df_dummy <- cbind(df_dummy, df$HighSales)
df <- df_dummy
colnames(df)[colnames(df)=="df$HighSales"] = "HighSales"

# encode target variable as a categorical variable
df$HighSales <- as.factor(df$HighSales)

# compute class proportion table on target variable
prop.table(table(df$HighSales))

# set random number seed for randomized partition
# different seed values will generate different partitions of the data
set.seed(1975)

# use the createDataPartition to randomly select observations to be placed in the training set
# specify the target variable (y)
# set the percentage of data to set aside for training (p)
indxTrain <- createDataPartition(y = df$HighSales, p=0.8, list=FALSE)

# define training set for cross-validation
training <- df[indxTrain,]

# define test set 
testing <- df[-indxTrain,]

# create a grid of parameter values to assess in k-fold cross-validation
# for regularized logistic regression, two parameters: alpha and lambda
# alpha parameter controls the mix between ridge regularization and lasso regularization
# alpha = 0 -> ridge, alpha = 1 -> lasso
# lambda corresponds to the regularization penalty that dampens the size of the coefficients
grid <-expand.grid(.alpha=0:1, .lambda = seq(0, 1, length = 100))

# specify model training process
# method = k-fold cross-validation 
# number = number of folds
ctrl <- trainControl(method = "cv", number = 10, classProbs = TRUE, summaryFunction = twoClassSummary)

# train model via 10-fold cross-validation
# first argument identifies y variable (before the ~) and the set of x variables (after the ~)
# note we are excluding the Store index variable 
# second argument (data) specifies training set 
# third argument (method) specifies prediction method (regularized logistic regression)
# fourth argument (trControl) specifies training process (cross-validation)
# fifth argument (preProcess) specifies that we need to center and scale variables
# sixth argument (tuneLength) specifies number of different combinations of the two parameters
# alpha and lambda to evaluate, the specific values of alpha and lambda are selected automatically
# alpha parameter controls the mix between ridge regularization and lasso regularization
# alpha = 0 -> ridge, alpha = 1 -> lasso
# lambda corresponds to the regularization penalty that dampens the size of the coefficients
logregFit <- train(HighSales ~ . - Store, data = training, method = "glmnet",
                trControl = ctrl, tuneGrid = grid, preProcess = c("center","scale"))


# identify values of alpha and lambda that maximize AUC for ROC curve in the 10-fold cross-validation
logregFit

# output the regularized logistic regression coefficients
coef(logregFit$finalModel, logregFit$bestTune$lambda)

# generate classifications on testing set using threshold of 0.5
logregPredictClass <- predict(logregFit,newdata = testing)

# generate predicted probabilities on testing set
logregPredictProb <- predict(logregFit,newdata = testing, type = "prob")

# output performance metrics using "Yes" as the positive class
# using 50% probability threshold
confusionMatrix(logregPredictClass, testing$HighSales, positive = "Yes" )

# AUC under ROC curve, Sensitivity, Specificity
tcs <-twoClassSummary(data = data.frame(obs=testing$HighSales, pred = logregPredictClass, 
                        logregPredictProb, 1 - logregPredictProb ), lev = levels(testing$HighSales))
tcs

# data structure for constructing ROC and lift curves
pred <- prediction(logregPredictProb[,2], testing$HighSales)

# plot AUC 
perAUC <- performance(pred,"tpr", "fpr")
plot(perAUC, main = paste('AUC:', tcs[1]))
abline(0,1)

# plot lift 
perLift <- performance(pred,"lift","rpp")
plot(perLift, main = 'Lift Curve')

# create a data frame with the probability estimates and test set observations 
# write this data frame to a csv file
df_test <- cbind(logregPredictProb, testing$HighSales)
write.csv(df_test, "logregprobability_predictions.csv")



