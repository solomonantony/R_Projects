# uncomment next line and execute if package not installed yet
# install.packages("caret")
# install.packages("rpart")
# install.packages("rpart.plot")
# install.packages("randomForest")

# load necessary libraries
library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)

# read in file from working directory
df<- read.csv("carseatsales_r.csv")

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
# for random forest, a critical parameter is mtry, the number of randomly
# selected candidate variables considered at each split in tree
# testing values of mtry from 1 to 10 (the number of variables)
grid <-expand.grid(.mtry=c(1:10))

# train model via 10-fold cross-validation
# first argument identifies y variable (before the ~) and the set of x variables (after the ~)
# note we are excluding the Store index variable
# second argument (data) specifies training set 
# third argument (method) specifies prediction method (random forest)
# fourth argument (trControl) specifies training process (cross-validation)
# fifth argument (tuneGrid) specifies the values of the parameter mtry to evaluate
# note: default size of random forest is 500 trees
regForestFit <- train(Sales ~ . - Store, data = training, method = "rf", trControl = ctrl, tuneGrid = grid)

# identify value of mtry that minimizes RMSE in the 10-fold cross-validation
regForestFit

# output variable importance metric for random forest
varImp(regForestFit, scale = FALSE)

# evaluating random forest performance on testing set
forestPredict <- predict(regForestFit,newdata = testing)

# output performance metrics
postResample(forestPredict, testing$Sales)

# create a data frame with the random forest estimates and test set observations 
# write this data frame to a csv file
df_test <- cbind(forestPredict, testing$Sales)
write.csv(df_test, "regressionforest_predictions.csv")

