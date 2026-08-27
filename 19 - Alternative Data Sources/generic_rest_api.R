# A huge amount of business data (currency rates, shipping status,
# weather, demographics) is available only through an API, not a
# downloadable file. This example uses a free, no-signup public API
# (REST Countries) so it runs with zero setup; the same GET/parse
# pattern applies to almost any REST API, including ones that need a key.

# install.packages("httr")
# install.packages("jsonlite")
library(httr)
library(jsonlite)

# GET() sends a request to the API's URL, just like visiting it in a browser
response <- GET("https://restcountries.com/v3.1/region/europe?fields=name,population,capital")

# status_code() confirms the request succeeded (200 means OK) before
# trying to use the result - good practice for any API call
status_code(response)

# content() with as = "text" gets the raw JSON text back; fromJSON()
# then parses it into R data structures (here, a data frame since the
# JSON is a list of similarly-shaped records)
countries_df <- fromJSON(content(response, as = "text", encoding = "UTF-8"), flatten = TRUE)
str(countries_df)

countries_df$country_name <- countries_df$name.common
top10 <- countries_df[order(-countries_df$population), c("country_name", "population")][1:10, ]
print(top10)

# --- chart: most populous countries in Europe, pulled live from the API ---
barplot(rev(top10$population / 1e6), names.arg = rev(top10$country_name),
        horiz = TRUE, las = 1, col = "steelblue",
        main = "Most Populous European Countries", xlab = "Population (millions)")

# --- most business APIs require a key, passed as a header instead of
# being fully public - the pattern is otherwise identical: ---
# response <- GET("https://api.example.com/data",
#                  add_headers(Authorization = paste("Bearer", Sys.getenv("MY_API_KEY"))))
