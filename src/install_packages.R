installed <- rownames(installed.packages())
required <- c("dplyr", "readr", "purrr", "stringr", "here",
              "glue", "readxl", "DBI", "RSQLite", "digest", "tidylog")
if (!all(required %in% installed)) {
  install.packages(required[!required %in% installed])
}
