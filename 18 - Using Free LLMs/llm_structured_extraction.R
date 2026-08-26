# Chapter 18 - Using Free LLMs
# One of the most practical business uses of an LLM: turning messy,
# unstructured text into a structured data frame you can actually
# analyze - e.g. pulling product name, sentiment, and a 1-5 rating out
# of free-text reviews, ready for the same summary/chart tools used
# elsewhere in this course. Prerequisite: Ollama installed and running
# (see ollama_basics.R in this folder).

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
  "The blender is powerful but way too loud - I'd give it 3 out of 5.",
  "Loved the wireless headphones, battery life is amazing! Easily a 5.",
  "The desk lamp broke after a week, pretty disappointed, maybe a 1 or 2."
)

# asking the LLM to respond in STRICT JSON is what makes the output
# machine-parseable with fromJSON() - this is the key technique for
# turning free text into structured data
extract_review_info <- function(review_text) {
  prompt <- paste0(
    "Extract information from this product review and respond with ONLY ",
    "valid JSON, no other text, in this exact format: ",
    '{"product": "...", "sentiment": "Positive/Negative/Neutral", "rating": 1-5}', "\n\n",
    "Review: \"", review_text, "\""
  )
  raw_response <- call_ollama(prompt)
  tryCatch(fromJSON(raw_response), error = function(e) list(product = NA, sentiment = NA, rating = NA))
}

extracted_list <- lapply(reviews, extract_review_info)
extracted_df <- do.call(rbind, lapply(extracted_list, as.data.frame))
extracted_df$review <- reviews

print(extracted_df)

# --- chart: extracted star ratings, now usable like any numeric column ---
barplot(as.numeric(extracted_df$rating), names.arg = extracted_df$product,
        col = "darkorange", ylim = c(0, 5),
        main = "LLM-Extracted Ratings by Product", ylab = "Rating (1-5)")
