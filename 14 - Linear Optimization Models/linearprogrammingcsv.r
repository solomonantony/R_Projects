library(lpSolve)
obj.fun <- read.csv("md_cost_r.csv")
constr <- read.csv("md_constraint_matrix_r.csv")
constr.dir <- read.csv("md_con_dir_r.csv")
rhs <- read.csv("md_rhs_r.csv")
md.sol <- lp("min", obj.fun, constr, constr.dir, rhs, compute.sens=TRUE)
md.sol$objval
md.sol$solution
md.sol$sens.coef.from
md.sol$sens.coef.to
md.sol$duals
md.sol$duals.from
md.sol$duals.to


