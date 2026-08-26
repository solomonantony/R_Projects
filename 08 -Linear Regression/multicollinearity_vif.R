# Fills a gap from Chapter 8: multipleregression.r fits a model with
# several predictors but never checks whether those predictors are
# highly correlated with each other (multicollinearity), which can
# make coefficient estimates unstable.

# install.packages("car")
library(car)

butler_with_deliveries_df <- data.frame(
  Time = c(9.3, 4.8, 8.9, 6.5, 4.2, 7.4, 8.9, 9.1),
  Miles = c(100, 50, 100, 100, 50, 80, 90, 90),
  Deliveries = c(4, 3, 4, 2, 2, 3, 4, 3)
)

butler_MLR <- lm(Time ~ Miles + Deliveries, data = butler_with_deliveries_df)

# vif() computes the Variance Inflation Factor for each predictor.
# As a rule of thumb, VIF > 5 or 10 signals problematic multicollinearity
vif_values <- vif(butler_MLR)
vif_values

# --- chart: bar chart of VIF values with the common threshold lines marked ---
barplot(vif_values, col = "steelblue", ylim = c(0, max(vif_values, 10) + 1),
        main = "Variance Inflation Factors", ylab = "VIF")
abline(h = 5, col = "orange", lty = 2, lwd = 2)
abline(h = 10, col = "red", lty = 2, lwd = 2)
legend("topright", legend = c("Caution (5)", "Serious (10)"),
       col = c("orange", "red"), lty = 2, lwd = 2)
