# Chapter 17 - Text Analytics
# Chapter 6 (textmining.r) already covers the tm-package workflow: Corpus,
# cleaning, DocumentTermMatrix, and a wordcloud. This chapter uses tidytext,
# the other major R approach to text - it represents text as "one word per
# row" instead of a document-term matrix, which plugs directly into the
# dplyr/ggplot2 tools already used elsewhere in this course.

# install.packages("tidytext")
# install.packages("dplyr")
# install.packages("ggplot2")
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

# unnest_tokens() splits each row of text into one row per word - the
# tidytext equivalent of building a document-term matrix
tidy_words <- reviews_df %>%
  unnest_tokens(word, text)

# anti_join() against the built-in stop_words lexicon removes common
# words (the, and, was, were...) the same way tm's stopwords() does
tidy_words_clean <- tidy_words %>%
  anti_join(stop_words, by = "word")

# count() tallies word frequency across the whole corpus
word_counts <- tidy_words_clean %>%
  count(word, sort = TRUE)

print(head(word_counts, 10))

# --- chart: bar chart of the most frequent words after cleaning ---
top_words <- head(word_counts, 10)
ggplot(top_words, aes(x = reorder(word, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Most Frequent Words (Stop Words Removed)", x = "Word", y = "Count")
