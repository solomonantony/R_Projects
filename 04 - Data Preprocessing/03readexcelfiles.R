
# install.packages("readxl")
library(readxl)

# read_excel() reads a single sheet into a data frame (like read.csv does for CSVs)
sales_df <- read_excel("sales_data.xlsx")

# sheet = lets you pick a specific tab by name or position; range = lets you
# grab a specific cell range instead of the whole sheet
q1_df <- read_excel("sales_data.xlsx", sheet = "Q1", range = "A1:D50")

# excel_sheets() lists all tab names in a workbook - useful before deciding
# which sheet to read
excel_sheets("sales_data.xlsx")

View(sales_df)
str(sales_df)
