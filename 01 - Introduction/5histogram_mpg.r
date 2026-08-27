suv_df <- read.csv("compact_suv_r.csv")
View(suv_df)
hist(suv_df$Overall.Miles.Per.Gallon, main = "Null",xlab= "Overall Miles Per Gallon")