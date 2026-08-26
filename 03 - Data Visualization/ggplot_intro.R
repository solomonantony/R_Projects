# Fills a gap from Chapter 3: every chart in this folder uses base R
# graphics (plot/hist/barplot). ggplot2 is the other major plotting
# system in R and is worth knowing since much of the R world uses it.

# install.packages("ggplot2")
library(ggplot2)

electronics_df <- data.frame(
  Commercials = c(2, 5, 1, 3, 4, 1, 5, 3),
  SalesVolume = c(50, 57, 41, 54, 54, 38, 63, 48)
)

# ggplot() builds a plot in layers: data + aesthetic mapping (aes) + a geom
ggplot(electronics_df, aes(x = Commercials, y = SalesVolume)) +
  geom_point() +                      # geom_point = scatter plot layer
  geom_smooth(method = "lm", se = FALSE) +  # adds a fitted trend line
  labs(title = "Sales Volume vs. Number of Commercials",
       x = "Number of Commercials", y = "Sales Volume")

# geom_bar/geom_col for categorical counts (compare to barplot() elsewhere)
category_df <- data.frame(Drink = c("Coke", "Pepsi", "Sprite", "Other"),
                           Count = c(130, 90, 60, 40))
ggplot(category_df, aes(x = Drink, y = Count)) +
  geom_col(fill = "steelblue") +
  labs(title = "Soft Drink Preference")
