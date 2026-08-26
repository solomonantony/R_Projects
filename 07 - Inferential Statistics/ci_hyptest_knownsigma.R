# Fills a gap from Chapter 7: cimeanunknownsigma.R and hyptestmeanunknownsigma.r
# use the t-distribution because the population sigma is unknown. When sigma
# IS known, the correct approach uses the normal distribution (z) instead -
# R has no built-in "z.test", so it's done manually with qnorm()/pnorm().

sample_mean <- 3.02   # e.g. average package weight
sigma <- 0.15          # known population standard deviation
n <- 40
mu0 <- 3.00             # hypothesized population mean

# --- Confidence interval for the mean (sigma known) ---
error <- qnorm(0.975) * sigma / sqrt(n)   # 95% margin of error
lower_lim <- sample_mean - error
upper_lim <- sample_mean + error
list(lower_lim, upper_lim)

# --- Hypothesis test for the mean (sigma known), two-tailed ---
z_stat <- (sample_mean - mu0) / (sigma / sqrt(n))
p_value <- 2 * (1 - pnorm(abs(z_stat)))
list(z_stat = z_stat, p_value = p_value)

# --- chart: standard normal curve with the rejection region shaded and
# the observed z-statistic marked - the classic way to visualize this test ---
z_vals <- seq(-4, 4, length.out = 300)
d_vals <- dnorm(z_vals)
crit <- qnorm(0.975)  # two-tailed 5% critical value

plot(z_vals, d_vals, type = "l", lwd = 2,
     main = "Hypothesis Test: Rejection Regions (alpha = 0.05)",
     xlab = "z", ylab = "Density")
polygon(c(z_vals[z_vals <= -crit], -crit), c(d_vals[z_vals <= -crit], 0), col = "salmon", border = NA)
polygon(c(crit, z_vals[z_vals >= crit]), c(0, d_vals[z_vals >= crit]), col = "salmon", border = NA)
abline(v = z_stat, col = "blue", lwd = 2)
legend("topright", legend = c("Rejection region", "Observed z"),
       fill = c("salmon", NA), border = c(NA, NA), col = c(NA, "blue"), lty = c(NA, 1))
