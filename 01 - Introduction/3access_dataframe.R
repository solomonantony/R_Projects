suv_df <- read.csv("compact_suv_r.csv") #Reads in the CSV file CompactSUV.csv into a data frame in R
View(suv_df) #Displays the data frame
str(suv_df) #Displays a summary of the columns in the data frame
suv_df$Owner.Satisfaction <- ordered(suv_df$Owner.Satisfaction, levels=c("D","C","B","A")) #Extracts a column of the data frame and converts to an ordered type
suv_df$Owner.Satisfaction  #Extracts specific column from data frame; displays values and levels since this is ordered variable
class(suv_df$Owner.Satisfaction)  #Displays class of variable from column Owner.Satisfaction
entry73 <- suv_df[7,3] #Stores the entry in row 7, column 3 of data frame as data object named entry73
entry73
class(entry73) #Identifies class of data object entry73
row7 <- suv_df[7,] #Row 7 of suv_df is stored in data object named row7
row7
class(row7) #Identifies class of data object row7
col3 <- suv_df[,3] #Column 3 of suv_df is stored in data object named col3
col3
class(col3) #Identifies class of data object col3