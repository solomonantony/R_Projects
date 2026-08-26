regional_df <- read.csv("kirklandregional_r.csv")
north <- regional_df$North
south <- regional_df$South
month <- paste0(regional_df$Month, "-01-2023")
month <- as.Date(month, "%b-%d-%Y")
plot(month, north,
     type = "l",
     col = "red",
     xlab = "Month",
     ylab = "Sales ($100s)")
lines(month, south, col = "blue")
legend("topright",
        legend=c("North", "South"),
        lty = "solid",
        col = c("red", "blue"))
