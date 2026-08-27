# Dummy-coding for categorical predictors is shown

sales_df <- data.frame(
  Sales = c(105, 98, 150, 142, 88, 95, 160, 155),
  AdSpend = c(10, 9, 15, 14, 8, 9, 16, 15),
  StoreType = factor(c("Mall", "Mall", "Standalone", "Standalone",
                        "Mall", "Mall", "Standalone", "Standalone"))
)

# lm() automatically converts a factor predictor into dummy (0/1) variables.
# One level becomes the reference category (alphabetically first, by default)
sales_mod <- lm(Sales ~ AdSpend + StoreType, data = sales_df)
summary(sales_mod)

# Confirm how R encoded the dummy variable
contrasts(sales_df$StoreType)

# relevel() lets you choose a different reference category, which changes
# how the coefficient is interpreted (but not the model's predictions)
sales_df$StoreType <- relevel(sales_df$StoreType, ref = "Standalone")
sales_mod2 <- lm(Sales ~ AdSpend + StoreType, data = sales_df)
summary(sales_mod2)

# --- chart: scatter plot colored by StoreType, with each group's own
# fitted line - shows visually what the dummy variable is capturing ---
plot(sales_df$AdSpend, sales_df$Sales,
     col = ifelse(sales_df$StoreType == "Mall", "blue", "darkgreen"),
     pch = 16, main = "Sales vs. Ad Spend by Store Type",
     xlab = "Ad Spend", ylab = "Sales")

for (lvl in levels(sales_df$StoreType)) {
  subset_df <- sales_df[sales_df$StoreType == lvl, ]
  sub_mod <- lm(Sales ~ AdSpend, data = subset_df)
  abline(sub_mod, col = ifelse(lvl == "Mall", "blue", "darkgreen"), lwd = 2)
}
legend("topleft", legend = levels(sales_df$StoreType),
       col = c("blue", "darkgreen"), pch = 16, lwd = 2)
