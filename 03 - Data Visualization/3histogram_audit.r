audit_df <- read.csv("audit_r.csv")
audit_times <- audit_df$Audit.Time
hist(audit_times, main = "Histogram of Audit Times",
     xlab = "Time (min)",
     xlim = c(10,35),
     col = "blue",
     breaks = 5)
