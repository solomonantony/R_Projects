library(dplyr)
library(tidyr)
brewersaddresses_df <- read.csv("tblbrewersaddresses_r.csv")
brewersaddresses_df %>% separate(Address, c('StreetAddress', 'CityName', 'State', 'ZipCode'), sep=", ")