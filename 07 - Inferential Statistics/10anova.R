# To compare THREE OR MORE group means at once, use ANOVA -
# a natural extension, and the folder never demonstrates it.

major_salaries_df <- data.frame(
  Major = rep(c("Finance", "Marketing", "Accounting"), each = 5),
  Salary = c(4200, 4350, 4100, 4400, 4250,
             3800, 3950, 3700, 3900, 3850,
             4500, 4600, 4400, 4550, 4650)
)

# aov() fits the analysis-of-variance model: Salary explained by Major
salary_aov <- aov(Salary ~ Major, data = major_salaries_df)

# summary() shows the F-statistic and p-value for "do the means differ?"
summary(salary_aov)

# If ANOVA is significant, TukeyHSD() shows which specific pairs of
# groups differ from each other
TukeyHSD(salary_aov)

# --- chart: boxplot comparing the groups being tested - the standard
# visual companion to any ANOVA output ---
boxplot(Salary ~ Major, data = major_salaries_df, col = "lightyellow",
        main = "Salary by Major", xlab = "Major", ylab = "Salary")

# --- chart: plot(TukeyHSD(...)) shows each pairwise difference with its
# confidence interval - intervals that cross zero indicate no significant difference ---
plot(TukeyHSD(salary_aov), las = 1)
