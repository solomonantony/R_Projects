

softdrink_counts <- c(Coke = 130, Pepsi = 90, Sprite = 60, Other = 40)

pie(softdrink_counts,
    main = "Soft Drink Preference",
    col = c("red", "blue", "green", "gray"))

# Note: bar charts (already covered elsewhere in this folder) are usually
# a better choice than pie charts when categories need precise comparison.
