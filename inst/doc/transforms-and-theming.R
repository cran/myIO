## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(myIO)

## ----lm-example, eval = FALSE-------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "point",
#     color = "#E69F00",
#     label = "points",
#     data = mtcars,
#     mapping = list(x_var = "wt", y_var = "mpg")
#   ) |>
#   addIoLayer(
#     type = "line",
#     transform = "lm",
#     color = "red",
#     label = "trend",
#     data = mtcars,
#     mapping = list(x_var = "wt", y_var = "mpg")
#   )

## ----cumulative-example, eval = FALSE-----------------------------------------
# df <- data.frame(
#   step  = c("Start", "Sales", "Returns", "Total"),
#   value = c(100, 50, -20, NA),
#   is_total = c(FALSE, FALSE, FALSE, TRUE)
# )
# 
# myIO() |>
#   addIoLayer(
#     type = "waterfall",
#     label = "bridge",
#     data = df,
#     mapping = list(x_var = "step", y_var = "value", total = "is_total")
#   ) |>
#   defineCategoricalAxis(xAxis = TRUE)

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

## ----loess-example, eval = FALSE----------------------------------------------
# myIO(data = mtcars) |>
#   addIoLayer(type = "point", color = "#4E79A7", label = "Data",
#     mapping = list(x_var = "wt", y_var = "mpg")) |>
#   addIoLayer(type = "line", color = "#E15759", label = "LOESS",
#     transform = "loess",
#     mapping = list(x_var = "wt", y_var = "mpg"),
#     options = list(span = 0.5))

## ----mean-ci-example, eval = FALSE--------------------------------------------
# myIO(data = iris) |>
#   addIoLayer(type = "rangeBar", color = "#4E79A7", label = "Mean ± 95% CI",
#     transform = "mean_ci",
#     mapping = list(x_var = "Species", y_var = "Sepal.Length"),
#     options = list(level = 0.95)) |>
#   defineCategoricalAxis(xAxis = TRUE)

## ----regression-composite, eval = FALSE---------------------------------------
# myIO(data = mtcars) |>
#   addIoLayer(type = "regression", label = "MPG vs Weight",
#     mapping = list(x_var = "wt", y_var = "mpg"),
#     options = list(method = "lm", showCI = TRUE, showStats = TRUE))

## ----smooth-example, eval = FALSE---------------------------------------------
# df <- data.frame(x = 1:100, y = cumsum(rnorm(100)))
# 
# myIO(data = df) |>
#   addIoLayer(type = "line", color = "#CCCCCC", label = "Raw",
#     mapping = list(x_var = "x", y_var = "y")) |>
#   addIoLayer(type = "line", color = "#E15759", label = "SMA-10",
#     transform = "smooth",
#     mapping = list(x_var = "x", y_var = "y"),
#     options = list(method = "sma", window = 10))

## ----theme-basic, eval = FALSE------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "point",
#     color = "#56B4E9",
#     label = "scatter",
#     data = mtcars,
#     mapping = list(x_var = "wt", y_var = "mpg")
#   ) |>
#   setTheme(
#     text_color = "#e0e0e0",
#     grid_color = "#333333",
#     bg = "#1a1a2e",
#     font = "Fira Code, monospace"
#   )

## ----theme-custom, eval = FALSE-----------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "bar",
#     color = "coral",
#     label = "bars",
#     data = mtcars,
#     mapping = list(x_var = "cyl", y_var = "mpg")
#   ) |>
#   defineCategoricalAxis(xAxis = TRUE) |>
#   setTheme(
#     bg = "#fafafa",
#     text_color = "#333",
#     "border-radius" = "8px"
#   )

## ----dark-mode, eval = FALSE--------------------------------------------------
# aq <- airquality
# aq$Month <- paste0("M", aq$Month)
# 
# myIO() |>
#   addIoLayer(
#     type = "line",
#     color = c("#00d2ff", "#ff6b6b", "#feca57", "#48dbfb", "#ff9ff3"),
#     label = "Month",
#     data = aq,
#     mapping = list(x_var = "Day", y_var = "Temp", group = "Month")
#   ) |>
#   setTheme(
#     text_color = "#b0b0b0",
#     grid_color = "#2d2d2d",
#     bg = "#0d1117",
#     font = "Inter, system-ui, sans-serif"
#   )

