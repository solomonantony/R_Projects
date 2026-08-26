suv_df <- read.csv("compact_suv_r.csv")  #Read in data from CSV file as a data frame
View(suv_df)  #Displays the data frame
str(suv_df) #Displays a summary of the data frame
suv_df$Owner.Satisfaction <- ordered(suv_df$Owner.Satisfaction, levels=c("D","C","B","A"))  #Extracts column and changes variable type to ordered
sub_df <- suv_df[c(1:5),c(1:3,6)]  #Creates a new data frame from first five rows and columns 1, 2, 3 and 6
sub_df  #Display summary of data frame
rec_df <- subset(suv_df, Recommended == "Yes" & (Overall.Miles.Per.Gallon > 25 | Owner.Satisfaction == "A")) #Creates new data frame based on logical arguments
suv_df$NewRec <- suv_df$Recommended
slow_rows <- which(suv_df$Acceleration..0.60..Sec > 9)  #s rows that satisfy stated condition
slow_rows  #Displays extracted rows
suv_df$Recommended <- NULL #Deletes original variable Recommended
View(suv_df)  #Displays the updated data frame
summary(suv_df)  #Displays a statistical summary of the data frame