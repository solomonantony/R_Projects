#  nonlinearprogramming.r jumps straight into
# a constrained nloptr problem. Base R's optim() handles the simpler
# UNCONSTRAINED case and is usually taught first as a stepping stone.

# minimize a simple cost function: cost = (x - 4)^2 + (y - 6)^2
# (this has an obvious minimum at x=4, y=6, useful for checking optim() works)
cost_fn <- function(params) {
  x <- params[1]
  y <- params[2]
  (x - 4)^2 + (y - 6)^2
}

# par = starting guess; fn = the function to minimize
# method = "BFGS" is a common general-purpose gradient-based algorithm
result <- optim(par = c(0, 0), fn = cost_fn, method = "BFGS")

result$par     # the x, y values that minimize the function
result$value   # the minimum function value achieved
result$convergence  # 0 means it converged successfully

# --- chart: contour plot of the cost surface with the minimum marked -
# the standard way to visualize what an optimizer is searching over ---
x_seq <- seq(-2, 10, length.out = 100)
y_seq <- seq(-2, 12, length.out = 100)
z_grid <- outer(x_seq, y_seq, function(x, y) (x - 4)^2 + (y - 6)^2)

contour(x_seq, y_seq, z_grid, nlevels = 15,
        main = "Cost Function Contours with Optimum", xlab = "x", ylab = "y")
points(result$par[1], result$par[2], col = "red", pch = 17, cex = 1.8)
legend("topleft", legend = "Optimal (x, y)", col = "red", pch = 17)

# optim() minimizes by default; to MAXIMIZE a function, minimize its
# negative instead
profit_fn <- function(x) -(-(x - 5)^2 + 20)   # negated so optim still minimizes
optim(par = 0, fn = profit_fn, method = "Brent", lower = -10, upper = 20)
