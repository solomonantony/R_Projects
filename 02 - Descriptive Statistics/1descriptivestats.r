starting_salaries_df <- read.csv("startingsalaries_r.csv")
monthly_salary <- starting_salaries_df$Monthly.Starting.Salary....
summary(monthly_salary)
fivenum(monthly_salary)
quantile(monthly_salary, .25, type=6)
sd(monthly_salary)