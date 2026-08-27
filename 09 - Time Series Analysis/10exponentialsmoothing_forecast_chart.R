# Adds charting + an actual forecast to exponentialsmoothing.r
library(TTR)

set.seed(42)
gasoline_sales <- round(1200 + cumsum(rnorm(20, mean = 5, sd = 40)))
weeks <- 1:length(gasoline_sales)

# exponential smoothing with alpha = 0.2 (same as the original file's ratio)
gas_ema.2 <- EMA(gasoline_sales, n = 1, ratio = 0.2)

# the forecast for the NEXT period equals the most recent smoothed value
next_week <- length(weeks) + 1
forecast_value <- tail(gas_ema.2, 1)

# --- chart: actual sales, the smoothed line, and the forecast point ---
plot(weeks, gasoline_sales, type = "o", pch = 16, col = "black",
     xlim = c(1, next_week), ylim = range(c(gasoline_sales, forecast_value)),
     main = "Gasoline Sales: Exponential Smoothing Forecast (alpha = 0.2)",
     xlab = "Week", ylab = "Sales")
lines(weeks, gas_ema.2, col = "blue", lwd = 2)
points(next_week, forecast_value, col = "red", pch = 17, cex = 1.5)
legend("topleft", legend = c("Actual Sales", "Smoothed Series", "Forecast"),
       col = c("black", "blue", "red"), pch = c(16, NA, 17), lty = c(1, 1, NA))

cat("Forecast for week", next_week, ":", forecast_value, "\n")
