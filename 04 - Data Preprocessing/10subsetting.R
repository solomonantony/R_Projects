# Chapter 3 subsettingdata

 

treadwear_df <- read.csv("treadwear_r.csv")
str(treadwear_df)
Position=treadwear_df$Position.on.Automobile
newdata_df <- subset(treadwear_df, Position=="LF" & Tread.Depth <= 2)

View(newdata_df)