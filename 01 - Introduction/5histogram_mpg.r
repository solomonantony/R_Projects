setwd("../01 - Introduction")
suv_df <- read.csv("compact_suv_r.csv")
View(suv_df)
hist(suv_df$Overall.Miles.Per.Gallon,xlab= "Overall Miles Per Gallon", main="Compact cars mileage")