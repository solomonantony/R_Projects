# Most real business data lives in a database, not a CSV. R connects to
# essentially any database through the same DBI interface - only the
# driver package changes. This example uses SQLite (a free, file-based
# database with no server to set up) so it runs with zero signup; the
# commented block below shows the identical pattern for a real server.

# install.packages("DBI")
# install.packages("RSQLite")
library(DBI)

# dbConnect() opens a connection - for SQLite, ":memory:" creates a
# temporary database that exists only for this R session
con <- dbConnect(RSQLite::SQLite(), ":memory:")

sales_df <- data.frame(
  Region = c("North", "South", "East", "West", "North", "South"),
  Product = c("Widget", "Widget", "Gadget", "Gadget", "Gadget", "Widget"),
  Revenue = c(12000, 9500, 15000, 8700, 11200, 10300)
)

# dbWriteTable() loads a data frame into the database as a real SQL table
dbWriteTable(con, "sales", sales_df)

# dbGetQuery() sends SQL and returns the result as a data frame - the
# same SQL you'd write against any real company database
result <- dbGetQuery(con, "
  SELECT Region, SUM(Revenue) AS TotalRevenue
  FROM sales
  GROUP BY Region
  ORDER BY TotalRevenue DESC
")
print(result)

dbDisconnect(con)

# --- chart: revenue by region, pulled straight from the SQL query result ---
barplot(result$TotalRevenue, names.arg = result$Region, col = "steelblue",
        main = "Total Revenue by Region (via SQL)", ylab = "Revenue")

# --- connecting to a REAL production database looks almost identical -
# only the driver and connection details change: ---
#
# library(odbc)                    # for SQL Server / general ODBC connections
# con <- dbConnect(odbc::odbc(),
#                   Driver   = "SQL Server",
#                   Server   = "yourserver.database.windows.net",
#                   Database = "yourdatabase",
#                   UID      = "yourusername",
#                   PWD      = Sys.getenv("DB_PASSWORD"))  # never hardcode passwords
#
# library(RPostgres)                # for PostgreSQL
# con <- dbConnect(RPostgres::Postgres(),
#                   host = "yourhost", dbname = "yourdb",
#                   user = "youruser", password = Sys.getenv("DB_PASSWORD"))
#
# Once connected, dbGetQuery()/dbWriteTable()/dbDisconnect() work exactly
# the same way regardless of which database you're talking to.
