# Adds visualization to Chapter 14: linearprogramming.r solves the LP and
# prints numeric output (objective value, sensitivity ranges) but never
# shows the feasible region - the classic graphical way to understand what
# a 2-variable LP is actually doing. Uses the same problem as that file:
#   minimize 2*x1 + 3*x2
#   subject to:  x1 >= 125
#                x1 + x2 >= 350
#                2*x1 + x2 <= 600

library(lpSolve)

obj.fun <- c(2, 3)
constr <- matrix(c(1, 0,
                    1, 1,
                    2, 1), nrow = 3, byrow = TRUE)
constr.dir <- c(">=", ">=", "<=")
rhs <- c(125, 350, 600)

md.sol <- lp("min", obj.fun, constr, constr.dir, rhs, compute.sens = TRUE)
md.sol$objval
md.sol$solution

# --- chart: plot each constraint line and shade the feasible region ---
x1_vals <- seq(0, 400, length.out = 200)

# solve each constraint for x2 so it can be drawn as a line: x2 = f(x1)
line1_x1 <- 125                                  # x1 >= 125 is a vertical line
line2_x2 <- 350 - x1_vals                        # from x1 + x2 = 350
line3_x2 <- 600 - 2 * x1_vals                    # from 2x1 + x2 = 600

plot(NA, xlim = c(0, 400), ylim = c(0, 400),
     xlab = "x1", ylab = "x2", main = "LP Feasible Region and Optimal Solution")
abline(v = line1_x1, col = "blue", lwd = 2)
lines(x1_vals, line2_x2, col = "darkgreen", lwd = 2)
lines(x1_vals, line3_x2, col = "purple", lwd = 2)

# shade the feasible region: points satisfying all three constraints
grid_x1 <- seq(0, 400, length.out = 300)
grid_x2 <- seq(0, 400, length.out = 300)
feasible_points <- expand.grid(x1 = grid_x1, x2 = grid_x2)
feasible_points <- feasible_points[feasible_points$x1 >= 125 &
                                    feasible_points$x1 + feasible_points$x2 >= 350 &
                                    2 * feasible_points$x1 + feasible_points$x2 <= 600, ]
points(feasible_points$x1, feasible_points$x2, pch = 15, cex = 0.3, col = "lightgray")

# redraw the constraint lines on top of the shading, then mark the optimum
abline(v = line1_x1, col = "blue", lwd = 2)
lines(x1_vals, line2_x2, col = "darkgreen", lwd = 2)
lines(x1_vals, line3_x2, col = "purple", lwd = 2)
points(md.sol$solution[1], md.sol$solution[2], col = "red", pch = 17, cex = 2)

legend("topright",
       legend = c("x1 >= 125", "x1 + x2 >= 350", "2x1 + x2 <= 600", "Optimal Solution"),
       col = c("blue", "darkgreen", "purple", "red"), lwd = c(2, 2, 2, NA), pch = c(NA, NA, NA, 17))
