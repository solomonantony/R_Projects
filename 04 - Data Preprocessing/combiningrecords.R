treadwear_df <- read.csv("treadwear_r.csv")
treadwearnew_df <- read.csv("treadwearnew_r.csv")
combinedtread_df <- rbind(treadwear_df,treadwearnew_df)
View(combinedtread_df)