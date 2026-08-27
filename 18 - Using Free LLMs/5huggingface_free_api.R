# Ollama (used elsewhere in this folder) requires installing software and
# a reasonably capable computer to run models locally. Hugging Face's
# free Inference API is a cloud-based alternative: no local install, but
# it does require a free account and access token.
# Setup (one-time, outside R): create a free account at huggingface.co,
# then generate a token at huggingface.co/settings/tokens

library(httr)
library(jsonlite)

hf_token <- "YOUR_HUGGINGFACE_TOKEN_HERE"  # replace with your own free token

# this model is a small, fast, purpose-built sentiment classifier - a
# lighter-weight alternative to prompting a full general-purpose LLM
# when all you need is sentiment
call_huggingface_sentiment <- function(text, token = hf_token) {
  response <- tryCatch(
    POST(
      url = "https://api-inference.huggingface.co/models/distilbert-base-uncased-finetuned-sst-2-english",
      add_headers(Authorization = paste("Bearer", token)),
      body = list(inputs = text),
      encode = "json",
      timeout(30)
    ),
    error = function(e) NULL
  )

  if (is.null(response) || token == "YOUR_HUGGINGFACE_TOKEN_HERE") {
    return(NA)
  }
  content(response, as = "parsed", type = "application/json")
}

reviews <- c(
  "I really love how easy this dashboard is to use.",
  "The report generator keeps crashing, extremely frustrating.",
  "It works as expected, nothing more to say."
)

results <- lapply(reviews, call_huggingface_sentiment)

# each result is a nested list of label/score pairs; pull out the
# top-scoring label per review into a simple data frame
top_labels <- sapply(results, function(r) {
  if (is.null(r) || length(r) == 0 || is.na(r)[1]) return(NA)
  r[[1]]$label[which.max(sapply(r[[1]]$score, identity))]
})

results_df <- data.frame(review = reviews, sentiment = top_labels, stringsAsFactors = FALSE)
print(results_df)

# --- chart: sentiment counts from the free-tier API model ---
if (all(!is.na(results_df$sentiment))) {
  barplot(table(results_df$sentiment), col = c("firebrick", "forestgreen"),
          main = "Sentiment via Hugging Face Free Inference API", ylab = "Count")
} else {
  cat("Set a valid hf_token above to run this example and see the chart.\n")
}
