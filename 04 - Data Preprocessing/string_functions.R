# Fills a gap from Chapter 4: seperatingstrings.R shows tidyr::separate(),
# but the everyday base-R string cleaning functions are never shown.

city_raw <- "  New York "
codes_raw <- c("A-100", "B-201", "C-330")

# trimws() strips leading/trailing whitespace - very common after reading messy files
trimws(city_raw)

# paste()/paste0() join strings together (paste0 has no separator by default)
paste("Store", 1:3)
paste0("Store", 1:3)

# sub() replaces the FIRST match of a pattern; gsub() replaces ALL matches
sub("-", "_", codes_raw)
gsub("[0-9]", "", codes_raw)   # strip all digits, leaving just letters/punctuation

# toupper()/tolower() standardize case (useful before comparing/joining text fields)
toupper("recommended")
tolower("RECOMMENDED")

# grepl() tests whether a pattern is present (returns TRUE/FALSE) - handy for filtering
grepl("^A", codes_raw)
