# BigQuery is Google's cloud data warehouse - common at larger companies
# for querying very large datasets with SQL. It needs a Google Cloud
# project, but BigQuery's "sandbox mode" lets you query public datasets
# for free without entering a credit card (with usage limits).
# Setup (one-time, outside R): create a free project at
# console.cloud.google.com - no billing required for sandbox-mode usage.

# install.packages("bigrquery")
library(bigrquery)
library(DBI)

# bq_auth() opens a browser window to sign in with your Google account
bq_auth()

my_project <- "your-project-id-here"  # replace with your GCP project ID

# dbConnect() here works just like the SQLite example in
# relational_database.R - BigQuery is a database, just a cloud one
con <- dbConnect(
  bigrquery::bigquery(),
  project = "bigquery-public-data",  # the dataset's OWNING project
  dataset = "usa_names",
  billing = my_project                # YOUR project, which gets billed (free tier)
)

# query a public dataset of US baby names by year and state
result <- dbGetQuery(con, "
  SELECT name, SUM(number) AS total_babies
  FROM `bigquery-public-data.usa_names.usa_1910_2013`
  WHERE gender = 'F'
  GROUP BY name
  ORDER BY total_babies DESC
  LIMIT 10
")
print(result)

# --- chart: most common female baby names in the public dataset ---
barplot(rev(result$total_babies), names.arg = rev(result$name), horiz = TRUE,
        col = "steelblue", las = 1,
        main = "Top 10 Female Baby Names (1910-2013)", xlab = "Total Babies")
