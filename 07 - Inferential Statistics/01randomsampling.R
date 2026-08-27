

# read in data file from working directory into a data frame
EAI_df <- read.csv("eai_r.csv")
View(EAI_df)

# set the seed
set.seed(12345)


# Select a random sample of 30 rows (observations)
r_sample <- EAI_df[sample(nrow(EAI_df),30),]
list(r_sample)
