# Adds visualization to Chapter 4: findingmissingvalues.R identifies NAs
# with is.na()/complete.cases() but never shows WHERE they are, which is
# usually the more useful view when deciding how to clean a dataset.

customer_df <- data.frame(
  Name = c("Alice", "Bob", "Carol", "Dan", "Eve", "Frank"),
  Age = c(34, NA, 29, 41, NA, 38),
  Income = c(52000, 61000, NA, 58000, 47000, NA),
  Region = c("North", "South", "North", NA, "East", "South")
)

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
