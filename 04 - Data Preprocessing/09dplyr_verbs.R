library(dplyr)

sales_df <- data.frame(
  Region = c("North", "North", "South", "South", "East"),
  Rep = c("Alice", "Bob", "Carol", "Dan", "Eve"),
  Sales = c(12000, 9500, 15000, 8700, 11200)
)

# filter() keeps rows matching a condition
filter(sales_df, Sales > 10000)

# select() keeps only the listed columns
select(sales_df, Rep, Sales)

# mutate() adds/changes a column
mutate(sales_df, SalesInK = Sales / 1000)

# arrange() sorts rows; desc() reverses the order
arrange(sales_df, desc(Sales))

# group_by() + summarize() computes stats per group (e.g. per Region)
sales_df %>%
  group_by(Region) %>%
  summarize(TotalSales = sum(Sales), AvgSales = mean(Sales))

# %>% (the pipe) passes the result on its left into the first argument
# of the function on its right - lets you chain steps top to bottom
sales_df %>%
  filter(Sales > 9000) %>%
  select(Rep, Sales) %>%
  arrange(desc(Sales))

# --- chart: visualize the group_by/summarize result above ---
region_summary <- sales_df %>%
  group_by(Region) %>%
  summarize(TotalSales = sum(Sales))

barplot(region_summary$TotalSales, names.arg = region_summary$Region,
        col = "steelblue", main = "Total Sales by Region", ylab = "Total Sales")
