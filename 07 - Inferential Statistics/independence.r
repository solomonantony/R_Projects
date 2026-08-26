beerandchips_df <- read.csv("beerandchips_r.csv")
attach(beerandchips_df)
chisq.test(Beer.Preference,Snack.Chip.Preference,correct=FALSE)