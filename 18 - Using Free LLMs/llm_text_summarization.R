# Chapter 18 - Using Free LLMs
# Summarization is one of the most common business uses of an LLM -
# condensing long survey responses, meeting notes, or reports into a
# quick digest. Prerequisite: Ollama installed and running (see
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

long_feedback <- paste(
  "I have been a customer of this store for about five years now and overall",
  "my experience has been quite positive. The staff are usually friendly and",
  "willing to help when I have questions about a product. That said, in the",
  "last six months I have noticed that delivery times have gotten noticeably",
  "longer, and on two occasions my order arrived with items missing. I also",
  "think the mobile app could be improved - it is often slow to load and the",
  "search function does not always return relevant results. Despite these",
  "issues, I still plan to keep shopping here because the product quality",
  "itself remains excellent and the prices are competitive compared to",
  "other retailers I have tried."
)

summary_prompt <- paste0(
  "Summarize the following customer feedback in exactly one sentence, ",
  "focused on the main concern raised:\n\n", long_feedback
)

short_summary <- call_ollama(summary_prompt)
cat("Original (", nchar(long_feedback), "characters):\n", long_feedback, "\n\n")
cat("Summary (", nchar(short_summary), "characters):\n", short_summary, "\n")

# --- chart: length comparison, original vs. summary ---
lengths_df <- data.frame(
  Version = c("Original", "LLM Summary"),
  Characters = c(nchar(long_feedback), nchar(short_summary))
)
barplot(lengths_df$Characters, names.arg = lengths_df$Version,
        col = c("gray70", "steelblue"),
        main = "Text Length: Original vs. LLM Summary", ylab = "Characters")
