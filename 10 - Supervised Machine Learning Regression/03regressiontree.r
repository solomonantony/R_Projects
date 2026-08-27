# uncomment next line and execute if package not installed yet
# install.packages("caret")
# install.packages("rpart")
# install.packages("rpart.plot")

# load necessary libraries
library(caret)
library(rpart)
library(rpart.plot)

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

# train model via 10-fold cross-validation
# first argument identifies y variable (before the ~) and the set of x variables (after the ~)
# note we are excluding the Store variable as is just an index
# second argument (data) specifies training set 
# third argument (method) specifies prediction method (regression tree)
# fourth argument (trControl) specifies training process (cross-validation)
# fifth argument (tuneLength) specifies number of different values of complexity parameter to evaluate
# the specific values of cp evaluated are selected automatically
# for a tree, the complexity parameter (cp) prunes the tree and prevents overfitting
regTreeFit <- train(Sales ~ . - Store, data = training, method = "rpart", 
                    trControl = ctrl, tuneLength = 200)

# identify value of cp that minimizes RMSE in the 10-folds cross-validation
regTreeFit

# visualize the tree
rpart.plot(regTreeFit$finalModel)

# list rules of tree
rpart.rules(regTreeFit$finalModel)

# evaluating regression tree performance on testing set
treePredict <- predict(regTreeFit,newdata = testing)

# output performance metrics
postResample(treePredict, testing$Sales)

# create a data frame with the regression tree estimates and test set observations 
# write this data frame to a csv file
df_test <- cbind(treePredict, testing$Sales)
write.csv(df_test, "regressiontree_predictions.csv")

