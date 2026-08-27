
# --- chart: visualize which regions passed the threshold used above ---
region_sales <- c(12000, 18500, 9000, 21000)
region_names <- c("North", "South", "East", "West")
bar_colors <- ifelse(region_sales > 15000, "forestgreen", "gray70")
barplot(region_sales, names.arg = region_names, col = bar_colors,
        main = "Region Sales vs. 15,000 Threshold", ylab = "Sales")
abline(h = 15000, col = "red", lty = 2, lwd = 2)

