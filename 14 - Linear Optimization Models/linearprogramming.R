# Chapter 14 linearprogramming

# install packages if not previously installed
# install.packages("lpSolve")

library(lpSolve)
obj.fun <- c(2,3)
constr <- matrix(c(1, 0, 1, 1, 2, 1), nrow = 3, byrow=TRUE)
constr.dir <- c(">=", ">=", "<=")
rhs <- c(125, 350, 600)
md.sol <- lp("min", obj.fun, constr, constr.dir, rhs, compute.sens=TRUE)
md.sol$objval
md.sol$solution
md.sol$sens.coef.from
md.sol$sens.coef.to
md.sol$duals
md.sol$duals.from
md.sol$duals.to
