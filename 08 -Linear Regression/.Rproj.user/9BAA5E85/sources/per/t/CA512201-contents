# Fills a gap from Chapter 9: lineartrend.r/quadratictrend.r fit trend
# lines, but none of the files separate a series into trend, seasonal,
# and irregular components - a standard step before forecasting
# seasonal business data (e.g. monthly sales).

# AirPassengers is a built-in monthly time series (R ships with it)
ts_data <- AirPassengers

# ts() wraps a numeric vector so R knows its time structure;
# frequency = 12 tells R this is monthly data with a yearly cycle
# (shown here for reference - AirPassengers is already a ts object)
# my_ts <- ts(my_sales_vector, start = c(2020, 1), frequency = 12)

# decompose() splits the series into trend, seasonal, and random components
decomp <- decompose(ts_data)
plot(decomp)

# Pull out just the seasonally-adjusted series (original minus seasonal effect)
seasonally_adjusted <- ts_data - decomp$seasonal
plot(seasonally_adjusted, main = "Seasonally Adjusted Series")
