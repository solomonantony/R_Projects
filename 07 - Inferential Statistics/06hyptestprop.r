# testing a hypothesis about a population proportion

# read in data file from working directory into a data frame
women_golf_df <- read.csv("womengolf_r.csv")

# view the data in the data frame
View(women_golf_df)
str(women_golf_df)

# calculate the sample size
samp_size <- nrow(women_golf_df)

# create a data frame consisting only of the Female responses
females <- subset(women_golf_df,Golfer=="Female")

# count the number of Female responses
female_count <- nrow(females)

# perform the hypothesis test of the population proportion
test <- prop.test(female_count,samp_size,p=0.20,alternative="greater",conf.level=0.95,correct=FALSE)
list(test)
