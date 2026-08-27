treadwear_df <- read.csv("treadwear_r.csv")
treadwearmodels_df <- read.csv("treadwearmodels_r.csv")
mergededtread_df <- merge(treadwear_df,treadwearmodels_df)
View(mergededtread_df)