# Chapter 17 - Text Analytics
# Sentiment analysis scores text as positive/negative using a lexicon -
# a list of words pre-labeled by sentiment. This is one of the most
# common business uses of text data (customer reviews, survey comments,
# social media) and isn't covered anywhere else in this course.

# install.packages("tidytext")
# install.packages("textdata")   # provides the "bing" lexicon on first use
library(tidytext)
library(dplyr)
library(ggplot2)

reviews_df <- data.frame(
  doc_id = 1:4,
  text = c(
    "The customer service was excellent and the staff were very helpful.",
    "Delivery was late and the product arrived damaged, very disappointing.",
    "Great value for the price, I would definitely recommend this store.",
    "The website was confusing and checkout took far too long to complete."
  ),
  stringsAsFactors = FALSE
)

tidy_words <- reviews_df %>%
  unnest_tokens(word, text)

# get_sentiments("bing") returns a lexicon labeling each word "positive"
# or "negative" - inner_join() keeps only words that appear in both
# the reviews AND the lexicon
bing_lexicon <- get_sentiments("bing")

sentiment_words <- tidy_words %>%
  inner_join(bing_lexicon, by = "word")

print(sentiment_words)

# count positive/negative words PER REVIEW, then compute a net sentiment score
review_sentiment <- sentiment_words %>%
  count(doc_id, sentiment) %>%
  tidyr::pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
  mutate(net_sentiment = positive - negative)

print(review_sentiment)

# --- chart: net sentiment score per review, colored by direction ---
ggplot(review_sentiment, aes(x = factor(doc_id), y = net_sentiment,
                              fill = net_sentiment > 0)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(values = c("TRUE" = "forestgreen", "FALSE" = "firebrick")) +
  labs(title = "Net Sentiment Score by Review", x = "Review", y = "Positive - Negative Words")
