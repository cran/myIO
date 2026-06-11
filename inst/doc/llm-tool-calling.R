## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(myIO)
# Render tool results as the JSON an agent actually receives.
as_json <- function(x) {
  cat(jsonlite::toJSON(x, pretty = TRUE, auto_unbox = TRUE, null = "null"))
}

## -----------------------------------------------------------------------------
myio_list_chart_types()

## -----------------------------------------------------------------------------
attempt <- list(
  type = "boxplot",
  mapping = list(column_var = "Species", value_var = "Sepal.Width")
)
as_json(myio_validate_spec(attempt))

## -----------------------------------------------------------------------------
fixed <- list(
  type = "boxplot",
  mapping = list(x_var = "Species", y_var = "Sepal.Width")
)
as_json(myio_validate_spec(fixed))

## -----------------------------------------------------------------------------
length(myio_list_chart_types())   # chart types
length(myio_list_functions())     # exported function signatures

## -----------------------------------------------------------------------------
as_json(myio_chart_schema("boxplot"))

## -----------------------------------------------------------------------------
as_json(myio_validate_spec(
  list(type = "point", mapping = list(x_var = "wt", y_var = "mpg")),
  columns = list(wt = "numeric", mpg = "character")
))

## -----------------------------------------------------------------------------
as_json(myio_validate_call("setAxisFormat", list(axis_x = ".0f")))

## -----------------------------------------------------------------------------
myio_function_signature("setAxisFormat")

## -----------------------------------------------------------------------------
spec <- list(type = "boxplot",
             mapping = list(column_var = "Species", value_var = "Sepal.Width"))
res  <- myio_validate_spec(spec)

while (!res$valid) {
  for (err in res$errors) {
    if (identical(err$code, "UNKNOWN_MAPPING_KEY") && !is.null(err$suggestion)) {
      spec$mapping[[err$suggestion]] <- spec$mapping[[err$field]]
      spec$mapping[[err$field]] <- NULL
    }
  }
  res <- myio_validate_spec(spec)
}
as_json(spec)

