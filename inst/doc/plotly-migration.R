## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----plotly-scatter, eval = FALSE---------------------------------------------
# # plotly
# plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", mode = "markers")

## ----myio-scatter, eval = FALSE-----------------------------------------------
# # myIO
# myIO(data = mtcars) |>
#   addIoLayer(type = "point", label = "Cars",
#     mapping = list(x_var = "wt", y_var = "mpg"))

## ----plotly-lines, eval = FALSE-----------------------------------------------
# # plotly
# plot_ly(economics_long, x = ~date, y = ~value, color = ~variable,
#         type = "scatter", mode = "lines")

## ----myio-lines, eval = FALSE-------------------------------------------------
# # myIO
# myIO(data = economics_long) |>
#   addIoLayer(type = "line", label = "Trends",
#     mapping = list(x_var = "date", y_var = "value", group = "variable"))

## ----plotly-bar, eval = FALSE-------------------------------------------------
# # plotly
# plot_ly(data.frame(x = c("A","B","C"), y = c(10,20,15)),
#         x = ~x, y = ~y, type = "bar")

## ----myio-bar, eval = FALSE---------------------------------------------------
# # myIO
# myIO(data = data.frame(x = c("A","B","C"), y = c(10,20,15))) |>
#   addIoLayer(type = "bar", label = "Values",
#     mapping = list(x_var = "x", y_var = "y")) |>
#   defineCategoricalAxis(xAxis = TRUE)

## ----plotly-hist, eval = FALSE------------------------------------------------
# # plotly
# plot_ly(mtcars, x = ~mpg, type = "histogram")

## ----myio-hist, eval = FALSE--------------------------------------------------
# # myIO
# myIO(data = mtcars) |>
#   addIoLayer(type = "histogram", label = "MPG Distribution",
#     mapping = list(x_var = "mpg"),
#     options = list(bins = 15))

## ----plotly-box, eval = FALSE-------------------------------------------------
# # plotly
# plot_ly(iris, y = ~Sepal.Length, color = ~Species, type = "box")

## ----myio-box, eval = FALSE---------------------------------------------------
# # myIO
# myIO(data = iris) |>
#   addIoLayer(type = "boxplot", label = "Sepal Length",
#     mapping = list(x_var = "Species", y_var = "Sepal.Length"),
#     options = list(showOutliers = TRUE)) |>
#   defineCategoricalAxis(xAxis = TRUE)

## ----plotly-reg, eval = FALSE-------------------------------------------------
# # plotly (broken — CI band misaligns or disappears)
# model <- lm(mpg ~ wt, data = mtcars)
# preds <- data.frame(wt = seq(min(mtcars$wt), max(mtcars$wt), length.out = 50))
# preds <- cbind(preds, predict(model, preds, interval = "confidence"))
# plot_ly() |>
#   add_markers(data = mtcars, x = ~wt, y = ~mpg) |>
#   add_ribbons(data = preds, x = ~wt, ymin = ~lwr, ymax = ~upr) |>
#   add_lines(data = preds, x = ~wt, y = ~fit)

## ----myio-reg, eval = FALSE---------------------------------------------------
# # myIO (one call, CI computed internally)
# myIO(data = mtcars) |>
#   addIoLayer(type = "regression", label = "MPG vs Weight",
#     mapping = list(x_var = "wt", y_var = "mpg"),
#     options = list(method = "lm", showCI = TRUE, showStats = TRUE))

## ----plotly-annot, eval = FALSE-----------------------------------------------
# # plotly (annotations lost in ggplotly conversion)
# library(ggpubr)
# p <- ggboxplot(iris, x = "Species", y = "Sepal.Length") +
#   stat_compare_means(method = "t.test", comparisons = list(
#     c("setosa", "versicolor"), c("versicolor", "virginica")))
# ggplotly(p)  # brackets and p-values vanish

## ----myio-annot, eval = FALSE-------------------------------------------------
# # myIO (pairwise tests rendered natively)
# myIO(data = iris) |>
#   addIoLayer(type = "comparison", label = "Sepal Length",
#     mapping = list(x_var = "Species", y_var = "Sepal.Length"),
#     options = list(method = "t.test"))

## ----plotly-dark, eval = FALSE------------------------------------------------
# # plotly
# plot_ly(mtcars, x = ~wt, y = ~mpg, type = "scatter", mode = "markers") |>
#   layout(template = "plotly_dark")

## ----myio-dark, eval = FALSE--------------------------------------------------
# # myIO
# myIO(data = mtcars) |>
#   addIoLayer(type = "point", label = "Cars",
#     mapping = list(x_var = "wt", y_var = "mpg")) |>
#   setTheme(background = "#1a1a2e", text = "#e0e0e0",
#            grid = "#2a2a4a", font = "Inter")

