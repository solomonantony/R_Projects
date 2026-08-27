# Adds visualization to Regression. Diagnostic
# plots are the standard way to check regression assumptions visually.

butler_df <- data.frame(
  Time = c(9.3, 4.8, 8.9, 6.5, 4.2, 7.4, 8.9, 9.1, 3.4, 5.5),
  Miles = c(100, 50, 100, 100, 50, 80, 90, 90, 40, 60)
)

butler_slr <- lm(Time ~ Miles, data = butler_df)
summary(butler_slr)

# plot() on an lm object gives four diagnostic plots at once:
# 1) Residuals vs Fitted - checks for non-linearity (should look like a random cloud)
# 2) Q-Q plot - checks whether residuals are approximately normal (points near the line)
# 3) Scale-Location - checks for non-constant variance (should look flat)
# 4) Residuals vs Leverage - flags influential outlier points
par(mfrow = c(2, 2))
plot(butler_slr)
par(mfrow = c(1, 1))  # reset layout back to a single plot per chart

# --- chart: scatter plot with the fitted regression line, the most
# basic (but essential) regression visualization ---
plot(butler_df$Miles, butler_df$Time, pch = 16, col = "black",
     main = "Delivery Time vs. Miles Traveled", xlab = "Miles", ylab = "Time")
abline(butler_slr, col = "blue", lwd = 2)
