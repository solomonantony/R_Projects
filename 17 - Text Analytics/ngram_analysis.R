# Chapter 17 - Text Analytics
# Single-word analysis loses word order - "not good" and "good" would be
# treated identically. N-grams (word pairs, triples, etc.) preserve some
# of that context. This is commonly used to catch negations and common
# phrases that single-word frequency analysis misses.

library(tidytext)
library(dplyr)
library(ggplot2)
library(tidyr)

reviews_df <- data.frame(
  doc_id = 1:5,
  text = c(
    "The customer service was not good and the staff seemed unhelpful.",
    "Delivery was not late this time, everything arrived on schedule.",
    "Great customer service and very fast delivery, highly recommend.",
    "The checkout process was not easy and took far too long.",
    "Customer service was excellent, truly great experience overall."
  ),
  stringsAsFactors = FALSE
)

# token = "ngrams", n = 2 splits text into overlapping two-word phrases
# instead of single words
bigrams <- reviews_df %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)

print(head(bigrams$bigram, 10))

# separate() splits "word1 word2" into two columns so stop words can be
# filtered from EACH position (filtering the combined phrase directly
# would miss cases like "was not")
bigrams_split <- bigrams %>%
  separate(bigram, into = c("word1", "word2"), sep = " ")

bigrams_clean <- bigrams_split %>%
  filter(!word1 %in% stop_words$word | word1 == "not",  # keep "not" - it matters here
         !word2 %in% stop_words$word)

bigram_counts <- bigrams_clean %>%
  unite(bigram, word1, word2, sep = " ") %>%
  count(bigram, sort = TRUE)

print(bigram_counts)

# --- chart: most common two-word phrases ---
ggplot(head(bigram_counts, 8), aes(x = reorder(bigram, n), y = n)) +
  geom_col(fill = "darkorange") +
  coord_flip() +
  labs(title = "Most Common Two-Word Phrases", x = "Bigram", y = "Count")
