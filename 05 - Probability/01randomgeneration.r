

set.seed(42)  # makes the random draws reproducible

runif(10, min = 120, max = 140)    # 10 random draws from a uniform distribution
rnorm(10, mean = 36500, sd = 5000) # 10 random draws from a normal distribution
rbinom(10, size = 10, prob = 0.3)  # 10 random draws from a binomial distribution
rpois(10, lambda = 10)             # 10 random draws from a Poisson distribution

# a simple use case: simulate 1000 normal draws and check how close
# the sample mean/sd come to the specified parameters
sim <- rnorm(1000, mean = 36500, sd = 5000)
mean(sim)
sd(sim)
hist(sim, main = "Simulated Normal Draws", xlab = "Value")
