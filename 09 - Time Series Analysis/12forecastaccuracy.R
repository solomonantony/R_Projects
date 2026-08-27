# These three metrics are the
# standard way to compare competing forecasting methods.

actual <- c(120, 135, 128, 142, 150)
forecast <- c(118, 130, 133, 138, 145)

errors <- actual - forecast

# MAE: Mean Absolute Error - average size of the error, in original units
mae <- mean(abs(errors))

# MSE: Mean Squared Error - penalizes large errors more heavily than MAE
mse <- mean(errors^2)

# MAPE: Mean Absolute Percentage Error - error size relative to actual
# values, expressed as a percentage (useful for comparing across series
# with different scales)
mape <- mean(abs(errors / actual)) * 100

list(MAE = mae, MSE = mse, MAPE = mape)

# --- chart: actual vs. forecast, side by side ---
periods <- 1:length(actual)
plot(periods, actual, type = "o", pch = 16, col = "black",
     ylim = range(c(actual, forecast)),
     main = "Actual vs. Forecast", xlab = "Period", ylab = "Value")
lines(periods, forecast, type = "o", pch = 17, col = "red")
legend("topleft", legend = c("Actual", "Forecast"),
       col = c("black", "red"), pch = c(16, 17), lty = 1)
