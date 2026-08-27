# Google Sheets is extremely common for small teams tracking data
# collaboratively (survey responses, shared trackers, budgets). This is
# different from google_drive.R (which downloads whole FILES) - this
# package reads/writes directly into a live spreadsheet's cells.
# Setup: just a normal Google account - gs4_auth() opens a browser
# window to sign in the first time.

# install.packages("googlesheets4")
library(googlesheets4)

gs4_auth()

# a Sheet can be referenced by its full URL or just its ID
# (the long string of characters in the URL after /d/ and before /edit)
sheet_url <- "https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID_HERE/edit"

# read_sheet() pulls the data straight into a data frame
survey_df <- read_sheet(sheet_url, sheet = "Responses")
str(survey_df)

# do normal analysis, exactly as with any other data frame
satisfaction_summary <- aggregate(Satisfaction ~ Department, data = survey_df, mean)
print(satisfaction_summary)

# --- chart: average satisfaction score by department ---
barplot(satisfaction_summary$Satisfaction, names.arg = satisfaction_summary$Department,
        col = "steelblue", ylim = c(0, 5),
        main = "Average Satisfaction by Department", ylab = "Satisfaction (1-5)")

# sheet_write() sends a data frame back to Google Sheets as a NEW tab -
# useful for pushing an analysis result back for others to see live
sheet_write(satisfaction_summary, ss = sheet_url, sheet = "Satisfaction Summary")
