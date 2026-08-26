# Fills a gap from Chapter 15: binaryintegerprogramming.r and
# integerprogramming.r use all.bin/all.int, which force EVERY variable
# to be binary or integer. Many real problems mix variable types - some
# continuous, some integer - which needs the int.vec argument instead.

library(lpSolve)

# Example: maximize profit choosing production quantities for two
# products, where product 1 must be produced in whole units (e.g. a
# machine setup), but product 2 can be any continuous amount
obj.fun <- c(30, 20)                                   # profit per unit
constr <- matrix(c(2, 1,   # labor hours
                    1, 3), # material units
                  nrow = 2, byrow = TRUE)
constr.dir <- c("<=", "<=")
rhs <- c(40, 60)

# int.vec specifies WHICH variable positions must be integers (here, just
# variable 1); any variable not listed stays continuous
mip.sol <- lp("max", obj.fun, constr, constr.dir, rhs, int.vec = c(1))

mip.sol$objval
mip.sol$solution

# --- chart: bar chart of the optimal solution values, one bar per decision
# variable, since optimization output is otherwise just a vector of numbers ---
barplot(mip.sol$solution, names.arg = c("Product 1 (integer)", "Product 2 (continuous)"),
        col = c("steelblue", "lightgreen"),
        main = "Optimal Production Quantities", ylab = "Units")
