# uncomment next line and execute if package not installed yet
# install.packages("caret")

# load necessary libraries
library(caret)

# read in file from working directory
df<- read.csv("carseatsales_r.csv")

# review encoding of variables
# k-nn requires all variables to be numerically encoded
# categorical variables need to be ignored or transformed to numeric values
str(df)

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
# for k-nn, the critical parameter is k, the number of neighbors
# testing values of k from 1 to 100
grid <-expand.grid(.k=c(1:100))

# train model via 10-fold cross-validation
# first argument identifies y variable (before the ~) and the set of x variables (after the ~)
# note we are excluding the categorical variables for this k-nn experiment
# and the Store variable as it is just an index
# second argument (data) specifies training set 
# third argument (method) specifies prediction method (k-NN)
# fourth argument (trControl) specifies training process (cross-validation)
# fifth argument (tuneGrid) specifies the values of the parameter k to evaluate
# sixth argument (preProcess) specifies that we need to center and scale variables
knnFit <- train(Sales ~ . - Store - ShelfLoc - Urban - US, data = training, method = "knn",
                trControl = ctrl, tuneGrid = grid, preProcess = c("center","scale"))


# identify value of k that minimizes the RMSE in the 10-fold cross-validation
knnFit

# plot RMSE as a function of k 
plot(knnFit)

# evaluating k-NN performance on testing set
knnPredict <- predict(knnFit,newdata = testing)

# output performance metrics
postResample(knnPredict, testing$Sales)

# create a data frame with the k-NN regression estimates and test set observations 
# write this data frame to a csv file
df_test <- cbind(knnPredict, testing$Sales)
write.csv(df_test, "knnregression_predictions.csv")

