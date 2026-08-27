library(lpSolve)
obj.fun <- read.csv("icecold_npv_r.csv")
constr <- read.csv("icecold_constraint_matrix_r.csv")
constr.dir <- read.csv("icecold_con_dir_r.csv")	
rhs <- read.csv("icecold_rhs_r.csv")
icecold.sol <- lp("max", obj.fun, constr,constr.dir, rhs, all.bin=TRUE)
icecold.sol$objval
icecold.sol$solution

