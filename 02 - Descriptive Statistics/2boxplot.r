#Creates boxplot for Monthly Starting Salary data

starting_salaries_df <- read.csv("startingsalaries_r.csv")
monthly_salary <- starting_salaries_df$Monthly.Starting.Salary....
boxplot(monthly_salary, xlab="Monthly Starting Salary", horizontal=TRUE)
