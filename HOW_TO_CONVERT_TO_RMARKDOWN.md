# Converting a Script to R Markdown

This guide walks through converting a plain `.R` script into an `.Rmd`
report that saves your code, results, and charts together in one
shareable document. It uses
`Time Series Analysis and Forecasting/lineartrend_forecast_demo.Rmd`
as a worked example — open that file alongside its original script,
`lineartrend_forecast_chart.R`, to see the conversion side by side.

## The five steps

**1. Create a new `.Rmd` file and add a YAML header.**
This is the block at the very top between `---` lines. It sets the
title and, importantly, the output format:

```yaml
---
title: "Your Report Title"
author: "Your Name"
date: "`r Sys.Date()`"
output: html_document
---
```

`output` can be `html_document`, `pdf_document` (requires a LaTeX
installation), or `word_document`.

**2. Break your script into chunks.**
A chunk is a fenced block of R code. Everything between
` ```{r} ` and ` ``` ` runs as R, exactly like your original script.
Give each chunk a short name (no spaces) for easier navigation:

````
```{r fit-model}
model <- lm(Sales ~ Year, data = my_data)
summary(model)
```
````

You generally don't need to change the R code itself at all — copy it
in as-is. The main change is *where you break it up* (see step 3).

**3. Add narrative text and headers between chunks.**
This is what makes it a *report* instead of just a script wrapped in
fences. Use `##` for section headers and plain text for explanation,
right in between your code chunks:

```markdown
## Fitting the Trend Model

We fit a simple linear regression of Sales on Year.

```{r fit-model}
...
```

The R-squared above tells us how much of the variation in sales
the year explains.
```

A natural way to decide where to break chunks: one chunk per logical
step of the analysis (load data → fit model → forecast → chart),
with a header and a sentence or two of explanation before each.

**4. Let charts and printed output do their job automatically.**
Anything your code would normally print to the console (`summary()`,
a data frame, `print()`) or plot to the graphics window is captured
and embedded in the knitted report with no extra code. You do **not**
need `png()`, `ggsave()`, or `capture.output()` just to include these
in the report.

Two things *are* worth adding explicitly, since they don't print or
plot:
- `write.csv(my_results, "results.csv", row.names = FALSE)` — if you
  want the data as its own file (e.g., to open in Excel)
- `saveRDS(my_model, "my_model.rds")` — if you want to reload a
  fitted model later without refitting it (`readRDS("my_model.rds")`)

See the `save-outputs` chunk in the demo file for both in action.

**5. Knit it.**
In RStudio, click the **Knit** button at the top of the script editor
(or run `rmarkdown::render("yourfile.Rmd")` from the console). This
produces one output file — e.g., `yourfile.html` — containing your
narrative text, your code (if shown), every printed result, and every
chart, in order.

## Useful chunk options

Add these inside the curly braces, e.g. `{r fit-model, echo = FALSE}`:

| Option | Effect |
|---|---|
| `echo = FALSE` | hides the code, but still shows its output/chart |
| `results = "hide"` | runs the code and shows any chart, but hides printed text output |
| `fig.cap = "..."` | adds a caption under a chart |
| `warning = FALSE` | suppresses R warnings from appearing in the report |
| `message = FALSE` | suppresses messages (e.g., from `library()`) from appearing in the report |

## Two files, not one

Keep both the `.Rmd` (your editable, re-runnable source) and the
knitted output (`.html`/`.pdf`/`.docx`, your shareable results). The
`.Rmd` is what you'd edit and re-knit if your data or analysis
changes; the knitted file is the snapshot you'd hand in, post, or
share.
