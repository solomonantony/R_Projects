# forest/tree/knn/logistic/neural net
# classifiers are covered, but Naive Bayes - a fast, simple baseline
# classifier that's standard to introduce alongside these - is not.

# install.packages("caret")
# install.packages("e1071")
library(caret)

df <- iris
df$is_setosa <- factor(ifelse(df$Species == "setosa", "Yes", "No"))
df$Species <- NULL

set.seed(1975)
indxTrain <- createDataPartition(y = df$is_setosa, p = 0.8, list = FALSE)
training <- df[indxTrain, ]
testing <- df[-indxTrain, ]

ctrl <- trainControl(method = "cv", number = 10)

# method = "nb" fits a Naive Bayes model: it estimates each predictor's
# distribution separately per class and assumes predictors are
# independent given the class - fast to train, and a useful baseline
nbFit <- train(is_setosa ~ ., data = training, method = "nb", trControl = ctrl)

nbFit
nbPredictClass <- predict(nbFit, newdata = testing)
cm <- confusionMatrix(nbPredictClass, testing$is_setosa, positive = "Yes")
cm

# --- chart: the confusion matrix as a bar chart, showing correct vs.
# incorrect predictions per actual class ---
cm_table <- as.data.frame(cm$table)  # columns: Prediction, Reference, Freq
barplot(matrix(cm_table$Freq, nrow = 2, byrow = TRUE),
        beside = TRUE, names.arg = unique(cm_table$Reference),
        col = c("steelblue", "salmon"),
        legend.text = unique(cm_table$Prediction),
        args.legend = list(title = "Predicted"),
        main = "Naive Bayes: Predictions by Actual Class",
        xlab = "Actual Class", ylab = "Count")
