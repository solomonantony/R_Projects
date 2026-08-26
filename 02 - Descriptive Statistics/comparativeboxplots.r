#Creates comparative boxplots for the Starting Salary data by majors

major_salaries_df <- read.csv("majorsalaries_r.csv")
boxplot(Monthly.Starting.Salary.... ~ Major,
        data = major_salaries_df,
        xlab = "Business Major",
        ylab = "Monthly Starting Salary ($)")