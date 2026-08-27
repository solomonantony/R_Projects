treadwear_df <- read.csv("treadwear_r.csv")
is.na(treadwear_df)
treadwear_df[!complete.cases(treadwear_df),]
colSums(is.na(treadwear_df))
