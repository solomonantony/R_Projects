# Chapter 18 - Using Free LLMs
# Ollama (ollama.com) runs open-source LLMs (Llama, Mistral, etc.) locally
# on your own computer for free - no API key, no signup, no per-call cost.
# Prerequisite (one-time, outside R): install Ollama from ollama.com, then
# in a terminal run: ollama pull llama3
# Once that's done, Ollama runs a local web server, and R just talks to it
# like any other web API.

# install.packages("httr")
# install.packages("jsonlite")
library(httr)
library(jsonlite)

# POST() sends the prompt to Ollama's local REST API.
# encode = "json" tells httr to convert the R list into a JSON request body.
# stream = FALSE asks for the whole answer at once instead of word-by-word.
call_ollama <- function(prompt, model = "llama3") {
  response <- tryCatch(
    POST(
      url = "http://localhost:11434/api/generate",
      body = list(model = model, prompt = prompt, stream = FALSE),
      encode = "json",
      timeout(60)
    ),
    error = function(e) NULL
  )

  if (is.null(response)) {
    return("ERROR: could not reach Ollama. Is it installed and running (ollama serve)?")
  }

  # content() parses the JSON response body into an R list;
  # the model's answer is in the "response" field
  parsed <- content(response, as = "parsed", type = "application/json")
  parsed$response
}

prompt1 <- "In one sentence, explain why customer churn is costly for a business."
answer1 <- call_ollama(prompt1)
cat("Prompt:", prompt1, "\n\nResponse:", answer1, "\n")

# --- chart: compare response length across a few different prompts -
# a simple way to see how prompt wording affects answer length/verbosity ---
prompts <- c(
  "Explain customer churn in one sentence.",
  "Explain customer churn in detail, covering causes and business impact.",
  "What is customer churn?"
)

response_lengths <- sapply(prompts, function(p) nchar(call_ollama(p)))

barplot(response_lengths, names.arg = c("Short prompt", "Detailed prompt", "Basic prompt"),
        col = "steelblue", main = "Response Length by Prompt Style",
        ylab = "Characters in Response", las = 1)
