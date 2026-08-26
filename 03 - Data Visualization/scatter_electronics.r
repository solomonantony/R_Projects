electronics_df <- read.csv("electronics_r.csv")
number_commericals <- electronics_df$No..of.Commercials
sales_volume <- electronics_df$Sales.Volume
plot(x = number_commericals,
     y = sales_volume,
     main = "Sales Volume vs. Number of Commercials",
     xlab = "Number of Commercials",
     ylab = "Sales Volume",
     xlim = c(0,6),
     ylim = c(30,70))
abline(lm(sales_volume ~ number_commericals))