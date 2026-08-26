regional_df <- read.csv("kirklandregional_r.csv")
regional_sales_df <- regional_df[ ,-1]
regional_sales_matrix <- as.matrix(regional_sales_df)
barplot(t(regional_sales_matrix), 
        xlab = "Month", 
        ylab = "Sales ($100s)",
        names.arg = c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                     "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
        legend = c("North", "South"),
        beside = TRUE)