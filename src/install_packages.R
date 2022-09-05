installed <- rownames(installed.packages())
required <- c("dplyr", "readr", "purrr", "stringr", "here",
              "glue", "readxl", "DBI", "RSQLite", "digest", "tidylog",
              "knitr", # used to extract R code from Rmd in run_*.R files
              "testthat" # used for running tests in test_dwc_occurrence.R
)
if (!all(required %in% installed)) {
  install.packages(required[!required %in% installed])
}
