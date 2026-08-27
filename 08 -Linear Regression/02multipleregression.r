# read in data file from working directory into a data frame
butler_with_deliveries_df <- read.csv("butlerwithdeliveries_r.csv")

# view the data in the data frame
View(butler_with_deliveries_df)
str(butler_with_deliveries_df)

# estimate the multiple linear regression model
butler_MLR <- lm(Time ~ Miles + Deliveries, data= butler_with_deliveries_df)
summary(butler_MLR)

# calculate the predicted values 
butler.pred=predict(butler_MLR)

# calculate the residuals 
butler.res=resid(butler_MLR)

# plot the residuals against the predicted values and the residuals against the independent variable
plot(butler.pred,butler.res,ylab="Residuals",xlab="Predicted Values",main="Plot of Residuals vs. Predicted Values")

# plot the residuals against each of the independent variables
plot(butler_with_deliveries_df$Miles,butler.res,ylab="Residuals",xlab="Miles",main="Plot of Residuals vs. Miles")
plot(butler_with_deliveries_df$Deliveries,butler.res,ylab="Residuals",xlab="Deliveries",main="Plot of Residuals vs. Deliveries")

# calculate the confidence and prediction intervals for a new observation
newdata=data.frame(Miles=85,Deliveries=3)
predict(butler_MLR,newdata,interval="confidence",level=0.95)
predict(butler_MLR,newdata,interval="prediction",level=0.95)

# calculate the confidence and prediction intervals for multiple new observations
new_butler_df<-read.csv("newbutler_r.csv")
predict(butler_MLR,new_butler_df,interval="confidence",level=0.95)
predict(butler_MLR,new_butler_df,interval="prediction",level=0.95)
