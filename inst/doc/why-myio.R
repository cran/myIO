## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(myIO)

## ----ci-example, eval = FALSE-------------------------------------------------
# myIO(data = mtcars) |>
#   addIoLayer(type = "point", color = "#4E79A7", label = "Data",
#     mapping = list(x_var = "wt", y_var = "mpg")) |>
#   addIoLayer(type = "line", color = "#E15759", label = "Trend",
#     transform = "lm",
#     mapping = list(x_var = "wt", y_var = "mpg")) |>
#   addIoLayer(type = "area", color = "#E15759", label = "95% CI",
#     transform = "ci",
#     mapping = list(x_var = "wt", y_var = "mpg"),
#     options = list(level = 0.95))

## ----regression-example, eval = FALSE-----------------------------------------
# myIO(data = mtcars) |>
#   addIoLayer(type = "regression", label = "MPG vs Weight",
#     mapping = list(x_var = "wt", y_var = "mpg"),
#     options = list(method = "lm", showCI = TRUE, showStats = TRUE))

## ----compose-example, eval = FALSE--------------------------------------------
# # Scatter + LOESS smooth + CI band + residual plot
# myIO(data = mtcars) |>
#   addIoLayer(type = "point", label = "Data",
#     mapping = list(x_var = "wt", y_var = "mpg")) |>
#   addIoLayer(type = "line", label = "LOESS", transform = "loess",
#     mapping = list(x_var = "wt", y_var = "mpg"),
#     options = list(span = 0.5))

## ----mean-ci-example, eval = FALSE--------------------------------------------
# myIO(data = iris) |>
#   addIoLayer(type = "rangeBar", label = "Mean ± 95% CI",
#     transform = "mean_ci",
#     mapping = list(x_var = "Species", y_var = "Sepal.Length"),
#     options = list(level = 0.95)) |>
#   defineCategoricalAxis(xAxis = TRUE) |>
#   setAxisFormat(xLabel = "Species", yLabel = "Sepal Length")

