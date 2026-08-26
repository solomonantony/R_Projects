electronics_df <- read.csv("electronics_r.csv") #Reads in CSV file Electronics.csv as a data frame
number_commericals <- electronics_df$No..of.Commercials  #Reads in column of data from electronics_df as data object number_commercials
sales_volume <- electronics_df$Sales.Volume #Reads in column of data from electronics_df as data object sales_volume
cov(number_commericals, sales_volume) #Calculates covariance of number_commercials and sales_volume variables
cor(number_commericals, sales_volume) #Calculates correlation coefficient of number_commercials and sales_volume variables