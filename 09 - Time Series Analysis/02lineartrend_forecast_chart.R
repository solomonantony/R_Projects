# Adds charting + an actual future forecast to lineartrend.r

bicycle_df <- data.frame(
  Year = 2007:2016,
  Sales = c(21.6, 22.9, 25.5, 21.9, 27.5, 31.5, 29.7, 28.6, 30.9, 32.6)
)

bicycle_slr <- lm(Sales ~ Year, data = bicycle_df)
summary(bicycle_slr)

# predict() with newdata forecasts future years; interval = "prediction"
# also returns a lower/upper bound for the forecast
future_years <- data.frame(Year = 2017:2019)
forecast <- predict(bicycle_slr, newdata = future_years, interval = "prediction")
forecast_df <- cbind(future_years, forecast)
print(forecast_df)

# --- chart: actual sales, fitted trend line, and forecasted years ---
plot(bicycle_df$Year, bicycle_df$Sales, pch = 16, col = "black",
     xlim = range(c(bicycle_df$Year, future_years$Year)),
     ylim = range(c(bicycle_df$Sales, forecast_df$upr)),
     main = "Bicycle Sales: Linear Trend Forecast",
     xlab = "Year", ylab = "Sales")
abline(bicycle_slr, col = "blue", lwd = 2)                     # fitted trend line
points(forecast_df$Year, forecast_df$fit, col = "red", pch = 17, cex = 1.5)
segments(forecast_df$Year, forecast_df$lwr, forecast_df$Year, forecast_df$upr,
         col = "red", lty = 2)                                  # prediction interval
legend("topleft", legend = c("Actual Sales", "Trend Line", "Forecast (± interval)"),
       col = c("black", "blue", "red"), pch = c(16, NA, 17), lty = c(NA, 1, 2))
