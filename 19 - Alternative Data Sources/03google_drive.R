# Google Drive is a common place small/mid-size businesses store shared
# files. The googledrive package lets R find and download files directly,
# instead of manually downloading and re-uploading them each time.
# Setup: just a normal Google account - drive_auth() opens a browser
# window to sign in the first time; no separate API key needed.

# install.packages("googledrive")
library(googledrive)

drive_auth()

# drive_find() searches your Drive by name pattern, like a search box
files <- drive_find(pattern = "sales_data", n_max = 10)
print(files)

# drive_download() saves a Drive file to the local working directory;
# overwrite = TRUE lets you re-run this without a manual prompt
drive_download(files$name[1], path = "sales_data_from_drive.csv", overwrite = TRUE)

sales_df <- read.csv("sales_data_from_drive.csv")
str(sales_df)

# --- chart: same as any other data frame, once it's local ---
if ("Region" %in% names(sales_df) && "Revenue" %in% names(sales_df)) {
  region_totals <- aggregate(Revenue ~ Region, data = sales_df, sum)
  barplot(region_totals$Revenue, names.arg = region_totals$Region,
          col = "steelblue", main = "Revenue by Region (from Google Drive file)")
}

# uploading a NEW file to Drive works the same way, in reverse:
# drive_upload("local_report.csv", path = "report_from_R.csv")
