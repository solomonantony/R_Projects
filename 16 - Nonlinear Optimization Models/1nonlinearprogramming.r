library(nloptr)
eval_f <- function(x)	
{
  return (.0225*x[1]^2 + .0324*x[2]^2 + .0025*x[3]^2 + .027*x[1]*x[2] - .003*x[1]*x[3] + .01*x[2]*x[3])
}		
eval_eq <- function(x)
{
  return ( 1 - x[1] - x[2] - x[3])
} 
eval_ineq <- function(x)
{
  return (.14 - .15*x[1] - .2*x[2] - .1*x[3])
}
lb <- c(0,0,0)
ub <- c(1,1,1)
x0 <- c(.3, .3, .4)  
local_opts <- list( "algorithm" = "NLOPT_GN_ISRES", "xtol_rel" = 1.0e-15 )
opts <- list( "algorithm"= "NLOPT_GN_ISRES",
              "xtol_rel"= 1.0e-15,
              "maxeval"= 200000,
              "local_opts" = local_opts,
              "print_level" = 0 )  
portfolio <- nloptr ( x0 = x0,
                      eval_f = eval_f,
                      lb = lb,
                      ub = ub,
                      eval_g_ineq = eval_ineq,
                      eval_g_eq = eval_eq,
                      opts = opts
)  
print(portfolio)
