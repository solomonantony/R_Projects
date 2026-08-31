
# install.packages("dplyr")
# install.packages("tidyr")
library(dplyr)
library(tidyr)

customer_df <- data.frame(
  CustomerID = 1:8,
  Name = c("Alice", "Bob", "Carol", "Dan", "Eve", "Frank", "Grace", "Hank"),
  Age = c(34, NA, 29, 41, NA, 38, 45, 31),
  Income = c(52000, 61000, NA, 58000, 47000, NA, 71000, 49500),
  Region = c("North", "South", "North", NA, "East", "South", "North", NA),
  stringsAsFactors = FALSE
)

## ===========================================================
## PART 1: DETECTING AND VISUALIZING MISSING VALUES
## ===========================================================

# count NAs per column - the numeric summary
na_counts <- colSums(is.na(customer_df))
print(na_counts)

# --- chart: bar chart of missing-value counts per column ---
barplot(na_counts, col = "tomato",
        main = "Missing Values by Column", ylab = "Count of NA")

# --- chart: a simple heatmap-style grid showing WHICH cells are missing ---
# (TRUE/FALSE turned into a matrix of 1s/0s so image() can plot it)
na_matrix <- as.matrix(is.na(customer_df)) * 1
image(t(na_matrix[nrow(na_matrix):1, ]), axes = FALSE,
      main = "Missing Value Map (yellow = missing)", col = c("steelblue", "yellow"))
axis(1, at = seq(0, 1, length.out = ncol(customer_df)), labels = colnames(customer_df))

## ===========================================================
## PART 2: HANDLING MISSING VALUES
## ===========================================================
## There is no single "correct" way to handle missing data - the right
## choice depends on how much is missing, why it's missing, and what
## the data will be used for. Below are the main strategies, roughly
## in order from simplest/most aggressive to most careful.

# --- Strategy 1: Listwise deletion - drop any ROW with an NA anywhere ---
# Simplest option. Safe when only a few rows are affected, but wastes
# an entire row's worth of good data (e.g. Name, Region) just because
# ONE column (e.g. Age) was missing.
customer_complete <- na.omit(customer_df)
# equivalently with dplyr:
customer_complete <- customer_df %>% filter(complete.cases(.))
cat("Rows before:", nrow(customer_df), " | after listwise deletion:", nrow(customer_complete), "\n")

# --- Strategy 2: Column deletion - drop a COLUMN if too much of it is missing ---
# Appropriate when a column is so sparse it can't be reliably used or
# imputed - e.g. drop any column missing more than 40% of its values.
missing_share <- colMeans(is.na(customer_df))
cols_to_drop <- names(missing_share[missing_share > 0.4])
customer_dropcols <- customer_df %>% select(-all_of(cols_to_drop))
print(missing_share)

# --- Strategy 3: Mean/median imputation (numeric columns) ---
# Fills NAs with the column's average instead of discarding the row.
# Keeps all rows, but artificially reduces variance and can distort
# relationships involving that variable - reasonable for a small share
# of missing values, risky if a large share is missing.
customer_imputed <- customer_df %>%
  mutate(Age = ifelse(is.na(Age), mean(Age, na.rm = TRUE), Age),
         Income = ifelse(is.na(Income), median(Income, na.rm = TRUE), Income))
print(customer_imputed)

# --- Strategy 4: Mode imputation (categorical columns) ---
# The numeric mean doesn't apply to a category like Region - use the
# most FREQUENT category instead.
get_mode <- function(x) {
  freq_table <- table(x)
  names(freq_table)[which.max(freq_table)]
}
customer_imputed <- customer_imputed %>%
  mutate(Region = ifelse(is.na(Region), get_mode(Region), Region))
print(customer_imputed)

# --- Strategy 5: coalesce() - fill with a specific fallback value ---
# Useful when missing has a natural default, e.g. treating a missing
# "Region" as "Unknown" rather than guessing a value at all.
customer_df %>%
  mutate(Region = coalesce(Region, "Unknown"))

# --- Strategy 6: fill() - forward/backward fill for ordered/sequential data ---
# Appropriate for data with a natural order (time series, sorted logs)
# where the last known value is a reasonable stand-in - NOT appropriate
# for unordered data like this customer table, shown here for contrast.
daily_readings <- data.frame(
  Day = 1:6,
  Temperature = c(72, NA, NA, 75, 77, NA)
)
daily_readings %>% fill(Temperature, .direction = "down")  # carries the last value forward

# --- Strategy 7: flag that a value was imputed ---
# Imputing silently can hide how much of the "data" is actually a guess.
# Adding a companion indicator column preserves that information for
# later analysis (e.g. to see if imputed rows behave differently).
customer_flagged <- customer_df %>%
  mutate(Age_was_missing = is.na(Age),
         Age = ifelse(is.na(Age), mean(Age, na.rm = TRUE), Age))
print(customer_flagged)

## A more advanced option worth knowing about: model-based imputation
## (e.g. the `mice` or `VIM` packages) predicts each missing value from
## the OTHER columns instead of using a single overall mean - more
## accurate, but adds real complexity and is usually reserved for
## datasets where missingness is substantial and simple imputation
## would meaningfully bias the analysis.

# --- chart: compare the Income distribution across the different
# strategies, to see how each one changes the data ---
income_original <- customer_df$Income[!is.na(customer_df$Income)]
income_deleted <- customer_complete$Income
income_imputed <- customer_imputed$Income

boxplot(income_original, income_deleted, income_imputed,
        names = c("Original\n(NAs excluded)", "After Listwise\nDeletion", "After Mean\nImputation"),
        col = c("gray80", "salmon", "lightgreen"),
        main = "Effect of Missing-Value Strategy on Income Distribution")
