# Adds visualization to Chapter 7: independence.r runs chisq.test() but
# never shows the table it's testing - a mosaic plot (or grouped bar
# chart) is the standard way to see the pattern the test is evaluating.

# rows = product preference, columns = region
preference_table <- matrix(c(50, 30, 20,
                              25, 45, 30),
                            nrow = 2, byrow = TRUE,
                            dimnames = list(Preference = c("Brand A", "Brand B"),
                                             Region = c("North", "South", "West")))
print(preference_table)

chisq_result <- chisq.test(preference_table)
chisq_result

# --- chart: mosaic plot - box sizes show relative frequency, making it
# easy to see whether preference "looks" independent of region ---
mosaicplot(preference_table, main = "Brand Preference by Region",
           color = c("skyblue", "salmon"))

# --- chart: grouped bar chart as an alternative view of the same table ---
barplot(preference_table, beside = TRUE, col = c("skyblue", "salmon"),
         legend.text = TRUE, main = "Brand Preference by Region",
         xlab = "Region", ylab = "Count")
