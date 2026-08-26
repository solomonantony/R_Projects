# Fills a gap from Chapter 7: hyptestmeanunknownsigma.r only tests ONE
# sample against a fixed value. Comparing two groups (a very common
# business question - "did version A outsell version B?") needs the
# two-sample version of t.test().

store_a <- c(210, 195, 230, 205, 220, 198)  # daily sales, Store A
store_b <- c(180, 175, 190, 185, 178, 182)  # daily sales, Store B

# Independent samples t-test: are the two group means different?
# var.equal = FALSE (the default) uses Welch's correction, appropriate
# when the two groups may have different variances
t.test(store_a, store_b, var.equal = FALSE)

# Paired t-test: use when the two measurements are linked observations
# (e.g. the SAME stores before vs. after a promotion)
before <- c(210, 195, 230, 205, 220)
after  <- c(225, 200, 245, 210, 230)
t.test(before, after, paired = TRUE)

# --- chart: side-by-side boxplots for the independent-samples comparison ---
boxplot(store_a, store_b, names = c("Store A", "Store B"),
        col = c("lightblue", "lightgreen"),
        main = "Daily Sales: Store A vs. Store B", ylab = "Sales")

# --- chart: paired before/after, connecting each store's own two points ---
plot(rep(1, length(before)), before, xlim = c(0.5, 2.5), ylim = range(c(before, after)),
     xaxt = "n", xlab = "", ylab = "Sales", main = "Paired Comparison: Before vs. After",
     pch = 16, col = "black")
points(rep(2, length(after)), after, pch = 16, col = "black")
segments(1, before, 2, after, col = "gray50")
axis(1, at = c(1, 2), labels = c("Before", "After"))
