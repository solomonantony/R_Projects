# Chapter 17 - Text Analytics
# Raw word counts (as in tokenization_word_frequency.R) favor common
# words that appear in every document, which aren't very informative.
# TF-IDF (Term Frequency - Inverse Document Frequency) instead highlights
# words that are frequent in ONE document but rare across the rest of
# the corpus - much more useful for characterizing what makes a document
# distinctive (e.g. what topic each customer complaint is really about).

library(tidytext)
library(dplyr)
library(ggplot2)

reviews_df <- data.frame(
  doc_id = c("Review 1", "Review 2", "Review 3", "Review 4"),
  text = c(
    "The customer service was excellent and the staff were very helpful.",
    "Delivery was late and the product arrived damaged, very disappointing.",
    "Great value for the price, I would definitely recommend this store.",
    "The website was confusing and checkout took far too long to complete."
  ),
  stringsAsFactors = FALSE
)

word_counts_by_doc <- reviews_df %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word") %>%
  count(doc_id, word, sort = TRUE)

# bind_tf_idf() adds tf (term frequency), idf (inverse document frequency),
# and tf_idf (their product) as new columns to the word-count table
tfidf_words <- word_counts_by_doc %>%
  bind_tf_idf(word, doc_id, n) %>%
  arrange(desc(tf_idf))

print(head(tfidf_words, 10))

# --- chart: top TF-IDF term per document, faceted so each document's
# most distinctive word stands out separately ---
top_terms <- tfidf_words %>%
  group_by(doc_id) %>%
  slice_max(tf_idf, n = 3) %>%
  ungroup()

ggplot(top_terms, aes(x = reorder(word, tf_idf), y = tf_idf, fill = doc_id)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~doc_id, scales = "free_y") +
  coord_flip() +
  labs(title = "Top TF-IDF Terms by Review", x = NULL, y = "TF-IDF")
