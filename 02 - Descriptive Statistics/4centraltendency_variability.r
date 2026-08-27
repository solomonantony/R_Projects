
monthly_salary <- c(3450, 3550, 3600, 3200, 3800, 3650, 3400, 3900)

mean(monthly_salary)    # arithmetic average
median(monthly_salary)  # middle value when sorted (robust to outliers)
var(monthly_salary)     # variance: average squared deviation from the mean
IQR(monthly_salary)     # interquartile range: Q3 - Q1, a robust spread measure

# mean() and var() ignore NAs only if you tell them to
salary_with_missing <- c(monthly_salary, NA)
mean(salary_with_missing, na.rm = TRUE)

# --- chart: histogram with mean and median marked, so their difference
# (and what that implies about skew) is visible rather than just numeric ---
hist(monthly_salary, col = "lightblue", main = "Monthly Salary Distribution",
     xlab = "Salary")
abline(v = mean(monthly_salary), col = "red", lwd = 2)
abline(v = median(monthly_salary), col = "blue", lwd = 2, lty = 2)
legend("topright", legend = c("Mean", "Median"), col = c("red", "blue"),
       lty = c(1, 2), lwd = 2)
