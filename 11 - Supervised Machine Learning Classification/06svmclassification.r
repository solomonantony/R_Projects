# Support Vector Machines are one of the
# other standard classification algorithms typically taught alongside
# trees/knn/logistic regression/neural nets, but absent from this folder.

# install.packages("caret")
# install.packages("kernlab")
library(caret)

df <- iris
df$is_setosa <- factor(ifelse(df$Species == "setosa", "Yes", "No"))
df$Species <- NULL

set.seed(1975)
indxTrain <- createDataPartition(y = df$is_setosa, p = 0.8, list = FALSE)
training <- df[indxTrain, ]
testing <- df[-indxTrain, ]

ctrl <- trainControl(method = "cv", number = 10)

# svmRadial fits an SVM with a radial (non-linear) kernel.
# C = cost of misclassifying points (controls the margin's flexibility)
# sigma = controls how far the influence of a single point reaches
grid <- expand.grid(C = c(0.5, 1, 2), sigma = c(0.05, 0.1, 0.2))

svmFit <- train(is_setosa ~ ., data = training, method = "svmRadial",
                 trControl = ctrl, tuneGrid = grid, preProcess = c("center", "scale"))

svmFit
svmPredictClass <- predict(svmFit, newdata = testing)
confusionMatrix(svmPredictClass, testing$is_setosa, positive = "Yes")

# --- chart: SVM decision boundary - the classic SVM visualization.
# This only works cleanly in 2 dimensions, so we fit a SEPARATE small
# model here using just two predictors purely to make the boundary
# visible; the model above (trained on all 4 predictors) is the one
# whose accuracy actually matters.
library(e1071)
svm_2d <- svm(is_setosa ~ Petal.Length + Petal.Width, data = training,
              kernel = "radial")
plot(svm_2d, training, Petal.Length ~ Petal.Width,
     main = "SVM Decision Boundary (Petal Length vs. Petal Width)")
