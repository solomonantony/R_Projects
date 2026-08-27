# Financial and economic data is a common business analytics need -
# stock prices, exchange rates, interest rates. quantmod's getSymbols()
# pulls this from Yahoo Finance for free with NO signup or API key,
# making it the easiest entry point; a key-based alternative (Alpha
# Vantage) is noted at the bottom for when you need more reliability
# or data Yahoo doesn't provide.

# install.packages("quantmod")
library(quantmod)

# getSymbols() downloads historical price data and creates an object
# named "AAPL" directly in your environment (no need to assign it)
getSymbols("AAPL", src = "yahoo", from = "2023-01-01", to = Sys.Date())

head(AAPL)
str(AAPL)

# Cl() extracts just the closing price column from the OHLC data
closing_prices <- Cl(AAPL)

# --- chart: quantmod's own candlestick-style chart, built for finance data ---
chartSeries(AAPL, theme = "white", name = "AAPL Stock Price")

# --- chart: closing price with a 20-day moving average overlaid, the
# same moving-average technique used in Chapter 9's forecasting scripts ---
plot(closing_prices, main = "AAPL Closing Price with 20-Day Moving Average")
lines(SMA(closing_prices, n = 20), col = "blue", lwd = 2)
legend("topleft", legend = c("Closing Price", "20-Day MA"),
       col = c("black", "blue"), lty = 1)

# --- a key-based alternative: Alpha Vantage (free tier, signup required
# at alphavantage.co, ~25 requests/day on the free plan) ---
# library(httr); library(jsonlite)
# av_key <- "YOUR_ALPHA_VANTAGE_KEY_HERE"
# response <- GET("https://www.alphavantage.co/query",
#                  query = list(`function` = "TIME_SERIES_DAILY", symbol = "AAPL",
#                                apikey = av_key))
# av_data <- fromJSON(content(response, as = "text"))
