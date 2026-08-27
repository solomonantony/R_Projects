
# Topic modeling automatically groups documents into themes ("topics")
# based on which words tend to co-occur - useful for summarizing what a
# large collection of open-ended survey responses or reviews is actually
# about, without reading every one. LDA (Latent Dirichlet Allocation) is
# the standard algorithm for this.

# install.packages("topicmodels")
# install.packages("tm")
library(tm)
library(topicmodels)
library(tidytext)
library(dplyr)
library(ggplot2)

documents <- c(
  "The delivery was late and the package arrived damaged during shipping.",
  "Shipping took too long and the box was crushed when it arrived.",
  "The staff were friendly and very knowledgeable about the products.",
  "Customer service was excellent, the employees clearly knew their products well.",
  "The website was slow and checkout kept freezing on the payment page.",
  "The app crashed twice during checkout and the payment page was very slow."
)

# LDA (like most tm-based modeling) needs a DocumentTermMatrix as input
corpus <- VCorpus(VectorSource(documents))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
dtm <- DocumentTermMatrix(corpus)

# k = 3 tells LDA to look for 3 topics; this matches the 3 themes built
# into the example documents above (shipping, staff, website)
lda_model <- LDA(dtm, k = 3, control = list(seed = 42))

# tidy(..., matrix = "beta") extracts, for each topic, how strongly each
# word is associated with it
topics_beta <- tidy(lda_model, matrix = "beta")

top_terms <- topics_beta %>%
  group_by(topic) %>%
  slice_max(beta, n = 5) %>%
  ungroup()

print(top_terms)

# --- chart: top words per topic, one panel per topic ---
ggplot(top_terms, aes(x = reorder_within(term, beta, topic), y = beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free_y") +
  scale_x_reordered() +
  coord_flip() +
  labs(title = "Top Words per Topic (LDA)", x = NULL, y = "Beta (word-topic association)")
