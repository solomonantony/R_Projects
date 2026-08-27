dbinom(0:10,10,0.3) #Computes f(0), f(1), f(2)... f(10) from binomial probability distribution with n = 10, p = 0.3
pbinom(0:10,10,0.3) #Computes Pr(x<=0), Pr(x<=1), Pr(x<=2)... Pr(x<=10) from binomial probability distribution with n = 10, p = 0.3
dpois(5,10) #Computes f(5) from Poisson probability distribution with mean number of occurences in an interval = 10
ppois(5,10) #Computes Pr(x<=5) from Poisson probability distribution with mean number of occurences in an interval = 10
dhyper(1,5,7,3) #Computes f(1) from hypergeometric probability distribution when there are 5 possible successes, 7 possible failures, and the drawn sample size = 3
phyper(1,5,7,3) #Computes Pr(x<=1) from hypergeometric probability distribution when there are 5 possible successes, 7 possible failures, and the drawn sample size = 3