# Adds charting + an actual future forecast to quadratictrend.r, which
# fits lm(Revenue ~ Year + Year_sqrd) and prints summary() but never
# plots the curve or predicts a future year.

cholest_df <- data.frame(
  Year = 2010:2019,
  Revenue = c(23.1, 21.3, 27.4, 34.5, 39.8, 44.6, 50.2, 60.3, 68.9, 79.7)
)
cholest_df$Year_sqrd <- cholest_df$Year^2

cholest_quad <- lm(Revenue ~ Year + Year_sqrd, data = cholest_df)
summary(cholest_quad)

# newdata must include the SAME derived column (Year_sqrd) used to fit the model
future_years <- data.frame(Year = 2020:2022)
future_years$Year_sqrd <- future_years$Year^2
forecast <- predict(cholest_quad, newdata = future_years, interval = "prediction")
forecast_df <- cbind(future_years, forecast)
print(forecast_df)

# --- chart: actual revenue, fitted quadratic curve, and forecasted years ---
plot(cholest_df$Year, cholest_df$Revenue, pch = 16, col = "black",
     xlim = range(c(cholest_df$Year, future_years$Year)),
     ylim = range(c(cholest_df$Revenue, forecast_df$upr)),
     main = "Cholesterol Product Revenue: Quadratic Trend Forecast",
     xlab = "Year", ylab = "Revenue ($M)")

# curve the fitted line smoothly across the full range, including forecast years
all_years <- seq(min(cholest_df$Year), max(future_years$Year), by = 0.5)
fitted_curve <- predict(cholest_quad, newdata = data.frame(Year = all_years,
                                                             Year_sqrd = all_years^2))
lines(all_years, fitted_curve, col = "blue", lwd = 2)

points(forecast_df$Year, forecast_df$fit, col = "red", pch = 17, cex = 1.5)
segments(forecast_df$Year, forecast_df$lwr, forecast_df$Year, forecast_df$upr,
         col = "red", lty = 2)
legend("topleft", legend = c("Actual Revenue", "Quadratic Trend", "Forecast (± interval)"),
       col = c("black", "blue", "red"), pch = c(16, NA, 17), lty = c(NA, 1, 2))
