# OneDrive/SharePoint is the Microsoft-ecosystem equivalent of Google
# Drive - common in businesses standardized on Office 365. Microsoft365R
# connects using your normal Microsoft/school/work account.
# Setup: a Microsoft personal, work, or school account - the first call
# below opens a browser window to sign in (no separate API key needed).

# install.packages("Microsoft365R")
library(Microsoft365R)

# get_business_onedrive() is for a work/school Microsoft 365 account;
# use get_personal_onedrive() instead for a personal Microsoft account
my_drive <- get_business_onedrive()

# list_items() shows the files/folders at the root of your OneDrive,
# similar to drive_find() in google_drive.R
my_drive$list_items()

# download_file() saves a OneDrive file locally by its path in the drive
my_drive$download_file("Reports/sales_data.xlsx", dest = "sales_data_from_onedrive.xlsx")

library(readxl)
sales_df <- read_excel("sales_data_from_onedrive.xlsx")
str(sales_df)

# --- chart: same pattern as the other cloud-storage examples in this chapter ---
if ("Region" %in% names(sales_df) && "Revenue" %in% names(sales_df)) {
  region_totals <- aggregate(Revenue ~ Region, data = sales_df, sum)
  barplot(region_totals$Revenue, names.arg = region_totals$Region,
          col = "steelblue", main = "Revenue by Region (from OneDrive file)")
}

# uploading a result back to OneDrive works the same way, in reverse:
# my_drive$upload_file("local_report.csv", dest = "Reports/report_from_R.csv")
