
# install.packages("dplyr")
library(dplyr)

set.seed(42)
sales_df <- data.frame(
  OrderID = 1:30,
  OrderValue = c(round(rnorm(28, mean = 250, sd = 40)), 1450, 5)
  # 28 "normal" orders, plus one unusually large order (1450) and one
  # suspiciously tiny one (5) - a likely data-entry error
)

## ===========================================================
## PART 1: DETECTING OUTLIERS
## ===========================================================

# --- chart: boxplot - the quickest visual check. Points plotted
# separately beyond the whiskers are flagged as outliers by default ---
boxplot(sales_df$OrderValue, main = "Order Value", ylab = "Order Value ($)",
        col = "lightblue")

# --- chart: scatter plot against index - useful for spotting outliers
# in the order the data was collected (e.g. a data-entry glitch on one row) ---
plot(sales_df$OrderID, sales_df$OrderValue, pch = 16,
     main = "Order Value by Order ID", xlab = "Order ID", ylab = "Order Value ($)")

# --- Method 1: IQR rule (the same rule a boxplot uses behind the scenes) ---
# Flags anything more than 1.5x the interquartile range below Q1 or
# above Q3 - a robust rule since it's based on quartiles, not the mean,
# so it isn't itself thrown off by the outliers it's trying to detect.
q1 <- quantile(sales_df$OrderValue, 0.25)
q3 <- quantile(sales_df$OrderValue, 0.75)
iqr_val <- q3 - q1
lower_bound <- q1 - 1.5 * iqr_val
upper_bound <- q3 + 1.5 * iqr_val

outliers_iqr <- sales_df %>%
  filter(OrderValue < lower_bound | OrderValue > upper_bound)
cat("IQR bounds:", round(lower_bound, 2), "to", round(upper_bound, 2), "\n")
print(outliers_iqr)

# --- Method 2: Z-score rule ---
# Flags anything more than a given number of standard deviations from
# the mean (commonly 3). Simpler to explain than IQR, but LESS robust:
# a single extreme outlier inflates the mean/sd used to detect it,
# which can mask other outliers - the IQR method above is usually
# preferred for that reason.
sales_df <- sales_df %>%
  mutate(z_score = (OrderValue - mean(OrderValue)) / sd(OrderValue))

outliers_zscore <- sales_df %>% filter(abs(z_score) > 3)
print(outliers_zscore)

## ===========================================================
## PART 2: HANDLING OUTLIERS
## ===========================================================
## As with missing values, there's no single correct fix - the right
## choice depends on WHY the value is extreme. A data-entry error should
## usually be corrected or removed; a genuinely large but real order
## (a big client's bulk purchase) may be legitimate and worth keeping,
## or analyzed separately rather than discarded.

# --- Strategy 1: Investigate before doing anything ---
# Always the right first step - print the flagged rows and look at them
# in context before deciding. Never automate outlier removal blindly.
print(outliers_iqr)

# --- Strategy 2: Remove the outlier ---
# Appropriate when a value is clearly an error (e.g. the $5 order,
# likely a missing digit) and not a data point worth keeping at all.
sales_no_outliers <- sales_df %>%
  filter(OrderValue >= lower_bound & OrderValue <= upper_bound)
cat("Rows before:", nrow(sales_df), " | after removing outliers:", nrow(sales_no_outliers), "\n")

# --- Strategy 3: Cap/winsorize the value ---
# Instead of discarding the row entirely (and losing its other columns),
# pull extreme values IN to the nearest acceptable bound. Keeps every
# row while limiting how much any single value can distort an analysis.
sales_capped <- sales_df %>%
  mutate(OrderValue_capped = case_when(
    OrderValue > upper_bound ~ upper_bound,
    OrderValue < lower_bound ~ lower_bound,
    TRUE ~ OrderValue
  ))
print(sales_capped %>% filter(OrderValue != OrderValue_capped))

# --- Strategy 4: Transform the variable ---
# A log transformation compresses large values much more than small
# ones, which can pull in extreme values without removing or altering
# any single observation directly - common for right-skewed data like
# income, sales, or prices where large values are legitimate but rare.
sales_df <- sales_df %>%
  mutate(OrderValue_log = log(OrderValue))

# --- Strategy 5: Flag rather than change ---
# Same principle as flagging imputed values in the missing-data script -
# keep the original value, but add a column marking it as unusual, so
# later analysis can include or exclude it deliberately rather than
# having the decision baked in silently.
sales_df <- sales_df %>%
  mutate(is_outlier = OrderValue < lower_bound | OrderValue > upper_bound)
print(sales_df %>% filter(is_outlier))

# --- chart: compare the distribution across strategies, to see how
# each one changes the spread of the data ---
boxplot(sales_df$OrderValue, sales_no_outliers$OrderValue, sales_capped$OrderValue_capped,
        names = c("Original", "Outliers\nRemoved", "Outliers\nCapped"),
        col = c("gray80", "salmon", "lightgreen"),
        main = "Effect of Outlier-Handling Strategy on Order Value")
