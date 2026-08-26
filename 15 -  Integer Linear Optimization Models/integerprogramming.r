library(lpSolve)
obj.fun <- c(10,15)
constr <- matrix(c(282, 400, 4, 40, 1, 0), nrow = 3, byrow=TRUE)
constr.dir <- c("<=", "<=", "<=")
rhs <- c(2000, 140, 5)
eastborne.sol <- lp("max", obj.fun, constr, constr.dir, rhs, all.int=TRUE)
eastborne.sol$objval
eastborne.sol$solution

