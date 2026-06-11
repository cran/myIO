## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install-packages, eval = FALSE-------------------------------------------
# install.packages(c("arrow", "duckdb", "DBI", "base64enc", "cli", "curl", "openssl"))

## ----install-wasm, eval = FALSE-----------------------------------------------
# install.packages(c("arrow", "duckdb", "DBI", "base64enc", "cli", "curl", "openssl"))
# myIO::install_duckdb_wasm()
# myIO::duckdb_wasm_status()

## ----data-frame-source, eval = FALSE------------------------------------------
# \dontrun{
# library(myIO)
# 
# big <- data.frame(
#   id = seq_len(1e6),
#   x = rnorm(1e6),
#   y = rnorm(1e6)
# )
# 
# myIO(engine = "wasm") |>
#   addIoLayer(type = "point", label = "points",
#              mapping = list(x_var = "x", y_var = "y")) |>
#   setBigData(big, rowkey_col = "id")
# }

## ----arrow-source, eval = FALSE-----------------------------------------------
# \dontrun{
# library(arrow)
# library(myIO)
# 
# tab <- arrow_table(big)
# 
# myIO(engine = "wasm") |>
#   addIoLayer(type = "point", label = "points",
#              mapping = list(x_var = "x", y_var = "y")) |>
#   setBigData(tab, rowkey_col = "id")
# }

## ----file-source, eval = FALSE------------------------------------------------
# \dontrun{
# myIO(engine = "wasm") |>
#   addIoLayer(type = "histogram", label = "x",
#              mapping = list(x_var = "x")) |>
#   setBigData("data/observations.parquet", rowkey_col = "id")
# 
# myIO(engine = "wasm") |>
#   addIoLayer(type = "point", label = "remote",
#              mapping = list(x_var = "x", y_var = "y")) |>
#   setBigData("https://example.org/observations.csv", rowkey_col = "id")
# }

## ----dbi-source, eval = FALSE-------------------------------------------------
# \dontrun{
# library(DBI)
# library(duckdb)
# library(myIO)
# 
# con <- dbConnect(duckdb())
# dbWriteTable(con, "observations", big)
# 
# myIO(engine = "server") |>
#   addIoLayer(type = "point", label = "points",
#              mapping = list(x_var = "x", y_var = "y")) |>
#   setBigData(con, table = "observations", rowkey_col = "id")
# }

## ----threshold-option, eval = TRUE--------------------------------------------
options(myIO.crosstalk_threshold = 50000L)

## ----minimal-example, eval = FALSE--------------------------------------------
# \dontrun{
# library(myIO)
# 
# install.packages(c("arrow", "duckdb", "DBI", "base64enc", "cli", "curl", "openssl"))
# myIO::install_duckdb_wasm()
# 
# set.seed(1)
# events <- data.frame(
#   id = seq_len(250000),
#   time = as.POSIXct("2026-01-01", tz = "UTC") + seq_len(250000),
#   x = rnorm(250000),
#   y = rnorm(250000),
#   group = sample(LETTERS[1:4], 250000, replace = TRUE)
# )
# 
# myIO(engine = "wasm") |>
#   addIoLayer(type = "point", label = "events",
#              mapping = list(x_var = "x", y_var = "y", color = "group")) |>
#   setBrush(direction = "xy") |>
#   setBigData(events, rowkey_col = "id")
# }

