#Creates comparative boxplots for the Starting Salary data by majors
setwd("../02 - Descriptive Statistics")
major_salaries_df <- read.csv("majorsalaries_r.csv")
boxplot(Starting_Salary ~ Major,
        data = major_salaries_df,
        xlab = "Business Major",
        ylab = "Monthly Starting Salary ($)")
