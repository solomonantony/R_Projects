# read in data file from working directory into a data frame
armands_df <- read.csv("armands_r.csv")

# view the data in the data frame
View(armands_df)
str(armands_df)

# estimate the simple linear regression model
armands_SLR <- lm(Sales ~ Population, data = armands_df)
summary(armands_SLR)

# calculate the predicted values
armands.pred=predict(armands_SLR)

# calculate the residuals
armands.res=resid(armands_SLR)

# plot the residuals against the predicted values
plot(armands.pred,armands.res,ylab="Residuals",xlab="Predicted Values",main="Plot of Residuals vs. Predicted Values")

# plot the residuals against the independent variable
plot(armands_df$Population,armands.res,ylab="Residuals",xlab="Actual",main="Plot of Residuals vs. Student Population")

# calculate the standardized residuals and create a normal probability plot
armands.stdres=rstandard(armands_SLR)
qqnorm(armands.stdres,ylab="Standardized Residuals",xlab="Normal Scores",main=" Normal Probability Plot of Standardized Residuals")
list(armands.stdres)

# calculate the leverage values and Cook's D statistics
hatvalues(armands_SLR)
cooks.distance(armands_SLR)

# calculate the confidence and prediction intervals for a new observation
newdata=data.frame(Population=14)
predict(armands_SLR,newdata,interval="confidence",level=0.95)
predict(armands_SLR,newdata,interval="prediction",level=0.95)
