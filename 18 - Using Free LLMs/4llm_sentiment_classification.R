# Compares to sentiment_analysis.R  which used a fixed word
# lexicon (bing). An LLM can classify sentiment using its general language
# understanding instead - often more accurate on sarcasm, mixed reviews,
# or short/informal text a lexicon would miss, at the cost of being slower
# and less transparent about WHY it chose an answer.
# Prerequisite: Ollama installed and running with a model pulled (see
# ollama_basics.R in this folder).

library(httr)
library(jsonlite)

call_ollama <- function(prompt, model = "llama3") {
  response <- tryCatch(
    POST(url = "http://localhost:11434/api/generate",
         body = list(model = model, prompt = prompt, stream = FALSE),
         encode = "json", timeout(60)),
    error = function(e) NULL
  )
  if (is.null(response)) return(NA)
  content(response, as = "parsed", type = "application/json")$response
}

reviews <- c(
  "The staff went above and beyond to help me, wonderful experience.",
  "Package arrived three weeks late and half the items were missing.",
  "It was fine, nothing special but nothing wrong either.",
  "Yeah, 'great' service - waited an hour just to be told to come back tomorrow."
)

# a tightly constrained prompt makes the LLM's output easy to parse
# programmatically - asking for ONE WORD avoids having to parse free text
classify_sentiment <- function(review_text) {
  prompt <- paste0(
    "Classify the sentiment of this customer review as exactly one word: ",
    "Positive, Negative, or Neutral. Respond with only that one word.\n\n",
    "Review: \"", review_text, "\""
  )
  trimws(call_ollama(prompt))
}

results_df <- data.frame(
  review = reviews,
  sentiment = sapply(reviews, classify_sentiment),
  stringsAsFactors = FALSE
)

print(results_df)

# --- chart: distribution of LLM-assigned sentiment labels ---
sentiment_counts <- table(results_df$sentiment)
barplot(sentiment_counts, col = c("firebrick", "gray70", "forestgreen")[
          match(names(sentiment_counts), c("Negative", "Neutral", "Positive"))],
        main = "Review Sentiment (Classified by LLM)", ylab = "Count of Reviews")
