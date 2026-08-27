
# --- continuous example: shade the area under a normal curve ---
# P(X < 70) for a normal distribution with mean 75, sd 8
mean_val <- 75
sd_val <- 8
x_vals <- seq(mean_val - 4 * sd_val, mean_val + 4 * sd_val, length.out = 300)
y_vals <- dnorm(x_vals, mean = mean_val, sd = sd_val)

plot(x_vals, y_vals, type = "l", lwd = 2, col = "black",
     main = "Normal Distribution: P(X < 70)", xlab = "X", ylab = "Density")

# shade the region below 70 using polygon()
shade_x <- x_vals[x_vals <= 70]
shade_y <- y_vals[x_vals <= 70]
polygon(c(shade_x, 70, min(shade_x)), c(shade_y, 0, 0), col = "skyblue", border = NA)
abline(v = 70, col = "red", lty = 2)

p_below_70 <- pnorm(70, mean = mean_val, sd = sd_val)
cat("P(X < 70) =", round(p_below_70, 4), "\n")

# --- discrete example: bar chart of a binomial probability mass function ---
n <- 15
p <- 0.3
x_binom <- 0:n
probs <- dbinom(x_binom, size = n, prob = p)

bar_colors <- ifelse(x_binom <= 3, "orange", "gray70")  # highlight P(X <= 3)
barplot(probs, names.arg = x_binom, col = bar_colors,
        main = paste0("Binomial(n=", n, ", p=", p, ") - highlighting P(X <= 3)"),
        xlab = "Number of Successes", ylab = "Probability")

p_le_3 <- pbinom(3, size = n, prob = p)
cat("P(X <= 3) =", round(p_le_3, 4), "\n")
