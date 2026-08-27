# Adds charting + an actual future forecast to exponentialtrend.r

cholest_df <- data.frame(
  Year = 2010:2019,
  Revenue = c(23.1, 21.3, 27.4, 34.5, 39.8, 44.6, 50.2, 60.3, 68.9, 79.7)
)
cholest_df$ln_revenue <- log(cholest_df$Revenue)

cholest_exp <- lm(ln_revenue ~ Year, data = cholest_df)
summary(cholest_exp)

# forecasts come out on the LOG scale, so exp() converts them back to
# original dollar units before plotting/interpreting
future_years <- data.frame(Year = 2020:2022)
log_forecast <- predict(cholest_exp, newdata = future_years, interval = "prediction")
forecast_df <- cbind(future_years, exp(log_forecast))   # exponentiate fit/lwr/upr
print(forecast_df)

# --- chart: actual revenue, fitted exponential curve, forecasted years ---
plot(cholest_df$Year, cholest_df$Revenue, pch = 16, col = "black",
     xlim = range(c(cholest_df$Year, future_years$Year)),
     ylim = range(c(cholest_df$Revenue, forecast_df$upr)),
     main = "Cholesterol Product Revenue: Exponential Trend Forecast",
     xlab = "Year", ylab = "Revenue ($M)")

all_years <- seq(min(cholest_df$Year), max(future_years$Year), by = 0.5)
fitted_curve <- exp(predict(cholest_exp, newdata = data.frame(Year = all_years)))
lines(all_years, fitted_curve, col = "blue", lwd = 2)

points(forecast_df$Year, forecast_df$fit, col = "red", pch = 17, cex = 1.5)
segments(forecast_df$Year, forecast_df$lwr, forecast_df$Year, forecast_df$upr,
         col = "red", lty = 2)
legend("topleft", legend = c("Actual Revenue", "Exponential Trend", "Forecast (± interval)"),
       col = c("black", "blue", "red"), pch = c(16, NA, 17), lty = c(NA, 1, 2))
