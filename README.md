# R Business Analytics — Supplemental Scripts

## About This Codebase

This repository is a collection of R scripts written to **supplement** the R
source code that accompanies a Business Analytics textbook (covering topics
from introductory analytics and descriptive statistics through regression,
machine learning, time series forecasting, and optimization modeling).

While reviewing the original chapter code, a number of gaps were identified —
techniques, functions, or visualizations that a given chapter's topic would
typically call for but that weren't demonstrated in the existing files. This
repository fills those gaps and adds a few chapters on topics not in the
original textbook at all. Specifically, it includes:

- **Gap-filling scripts** for Chapters 1–16, adding functions and worked
  examples that rounded out each chapter's topic (e.g., random number
  generation for the probability chapter, two-sample and paired t-tests for
  the statistical inference chapter, mixed-integer programming for the
  optimization chapters), each with a brief explanation of what the new
  functions do.
- **Visualizations added throughout**, matched to whatever technique each
  script demonstrates (distribution curves, diagnostic plots, decision
  boundaries, feasible-region graphs, forecast charts, and more) rather than
  generic charts bolted on.
- **Three new chapters** not in the original textbook:
  - **Chapter 17 — Text Analytics**: tokenization, sentiment analysis,
    TF-IDF, n-grams, and topic modeling using the `tidytext` framework.
  - **Chapter 18 — Using Free LLMs**: calling free large language models
    (via a locally-run Ollama model, with a Hugging Face free-tier
    alternative) for sentiment classification, summarization, and
    structured data extraction from text.
  - **Chapter 19 — Alternative Data Sources**: connecting R to data sources
    beyond CSV/Excel files — relational databases, Google BigQuery, Google
    Drive, Google Sheets, Microsoft OneDrive, Amazon S3, a generic REST API,
    and a free financial data API.

The folder structure mirrors the original textbook's chapter numbering and
naming, so these scripts can be dropped alongside the original course
materials as additional or replacement examples.

## Who This Is For

- **Instructors** teaching a business analytics, data analytics, or applied
  statistics course in R who want additional worked examples, ready-made
  visualizations, or entirely new chapter material (text analytics, LLMs,
  external data sources) to extend their existing curriculum.
- **Students** in such a course looking for extra practice examples beyond
  what's covered in lecture, or a reference for functions and techniques
  not otherwise demonstrated in their course materials.
- **Self-learners** working through a business analytics textbook
  independently who want a broader set of runnable R examples per topic
  than the textbook alone provides.

This is **supplemental material**, not a standalone course — it assumes
you're working alongside a business analytics textbook or course and are
already generally familiar with R syntax and RStudio.

## How to Use These Files

1. **Browse by chapter.** Each folder corresponds to a chapter topic (e.g.,
   `Chapter 05 - Probability An Introduction to Modeling Uncertainty`).
   Scripts are named for the specific technique or gap they address (e.g.,
   `randomgeneration.r`, `anova.R`).

2. **Install required packages before running a script.** Each script lists
   the packages it needs near the top, usually as a commented-out
   `install.packages(...)` line — uncomment and run those once, then
   `library()` the package as shown. Not every script uses the same
   packages, so check each file rather than assuming one global setup.

3. **Most scripts run standalone.** Because the original textbook's source
   data files weren't available when these were written, most scripts use
   either a small built-in R dataset (e.g., `mtcars`, `iris`,
   `AirPassengers`) or a small synthetic dataset created inline in the
   script, so you can run them immediately without needing the original
   course data files. Swap in your own data (e.g., via `read.csv()`) where
   indicated to adapt an example to real coursework data.

4. **Some scripts require external setup beyond R.** Chapters 18 and 19 in
   particular connect to outside services and need one-time setup *outside*
   R before they'll run:
   - Chapter 18 (Free LLMs): requires installing
     [Ollama](https://ollama.com) and pulling a model (e.g.,
     `ollama pull llama3`), or a free Hugging Face account/token for the
     alternative script.
   - Chapter 19 (Alternative Data Sources): requires a Google, Microsoft,
     AWS, or Google Cloud account depending on the specific script — see
     the comments at the top of each file. A few (SQLite, the public REST
     API, and the Yahoo Finance stock data example) need no signup at all
     and run immediately.
   Each script's header comments spell out exactly what's needed.

5. **Read the comments.** Every script is written with inline comments
   explaining what each new function does and why it's useful — they're
   meant to be read alongside the code, not just executed.

## Disclaimer

This code was drafted with the assistance of an AI model (Anthropic's
Claude) based on a review of the original textbook's source code and is
provided **as a supplemental teaching resource only**. Please note:

- These scripts have **not been fully tested by executing them in R** in
  the environment they were written in (no R runtime was available at
  authoring time). While each has been carefully reviewed for correctness,
  you should **test every script yourself before using it in a classroom
  or any other setting** where correctness matters.
- Package APIs (especially for cloud-service packages like
  `Microsoft365R`, `aws.s3`, `bigrquery`, and `googlesheets4`) change over
  time; function names and arguments shown here reflect their documented
  behavior as of when this was written and **may require adjustment** for
  the package versions you have installed.
- Scripts that call external APIs or services (Chapters 18 and 19) depend
  on those third-party services' availability, pricing, free-tier limits,
  and terms of service, none of which are controlled by or guaranteed by
  this repository. Review each service's current terms and pricing before
  use, and never commit real API keys, passwords, or account credentials
  to this or any public repository.
- This material is **not affiliated with, endorsed by, or officially
  connected to** the publisher or authors of the original textbook whose
  chapter structure it follows.
- No warranty, express or implied, is made regarding the accuracy,
  completeness, or fitness for any particular purpose of this code. Use
  at your own discretion.

## License

*(Add your preferred license here — e.g., MIT, CC BY-NC — before
publishing this repository.)*
