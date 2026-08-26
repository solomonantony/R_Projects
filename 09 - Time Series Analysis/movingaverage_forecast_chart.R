# Adds charting + an actual forecast to movingaverages.r, which computes
# a moving average but never plots it or forecasts a future period.

library(TTR)

set.seed(42)
gasoline_sales <- round(1200 + cumsum(rnorm(20, mean = 5, sd = 40)))
weeks <- 1:length(gasoline_sales)

# 3-week moving average (same as the original file)
gas_ma3 <- SMA(gasoline_sales, n = 3)

# the forecast for the NEXT period equals the most recent moving average value
next_week <- length(weeks) + 1
forecast_value <- tail(gas_ma3[!is.na(gas_ma3)], 1)

# --- chart: actual sales, the moving average line, and the forecast point ---
plot(weeks, gasoline_sales, type = "o", pch = 16, col = "black",
     xlim = c(1, next_week), ylim = range(c(gasoline_sales, forecast_value)),
     main = "Gasoline Sales: 3-Week Moving Average Forecast",
     xlab = "Week", ylab = "Sales")
lines(weeks, gas_ma3, col = "blue", lwd = 2)                # the MA line
points(next_week, forecast_value, col = "red", pch = 17, cex = 1.5)  # forecast
legend("topleft", legend = c("Actual Sales", "Moving Average", "Forecast"),
       col = c("black", "blue", "red"), pch = c(16, NA, 17), lty = c(1, 1, NA))

cat("Forecast for week", next_week, ":", forecast_value, "\n")
