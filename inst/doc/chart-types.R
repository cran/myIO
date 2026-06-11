## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(myIO)

## ----line, eval = FALSE-------------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "line",
#     color = "steelblue",
#     label = "temperature",
#     data = airquality,
#     mapping = list(x_var = "Day", y_var = "Temp")
#   )

## ----point, eval = FALSE------------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "point",
#     color = "coral",
#     label = "scatter",
#     data = mtcars,
#     mapping = list(x_var = "wt", y_var = "mpg")
#   )

## ----bar, eval = FALSE--------------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "bar",
#     color = "steelblue",
#     label = "bars",
#     data = mtcars,
#     mapping = list(x_var = "cyl", y_var = "mpg")
#   ) |>
#   defineCategoricalAxis(xAxis = TRUE)

## ----area, eval = FALSE-------------------------------------------------------
# aq <- airquality[complete.cases(airquality), ]
# aq$TempLow <- aq$Temp - 5
# aq$TempHigh <- aq$Temp + 5
# 
# myIO() |>
#   addIoLayer(
#     type = "area",
#     color = "lightsteelblue",
#     label = "area",
#     data = aq,
#     mapping = list(x_var = "Day", low_y = "TempLow", high_y = "TempHigh")
#   )

## ----grouped-bar, eval = FALSE------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "groupedBar",
#     color = "steelblue",
#     label = "grouped",
#     data = mtcars,
#     mapping = list(x_var = "cyl", y_var = "mpg")
#   ) |>
#   defineCategoricalAxis(xAxis = TRUE)

## ----histogram, eval = FALSE--------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "histogram",
#     color = "steelblue",
#     label = "hist",
#     data = mtcars,
#     mapping = list(value = "mpg")
#   )

## ----donut, eval = FALSE------------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "donut",
#     color = c("#E69F00", "#56B4E9", "#009E73"),
#     label = "donut",
#     data = aggregate(mpg ~ cyl, data = mtcars, FUN = mean),
#     mapping = list(x_var = "cyl", y_var = "mpg")
#   )

## ----gauge, eval = FALSE------------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "gauge",
#     color = "steelblue",
#     label = "gauge",
#     data = data.frame(value = 0.75),
#     mapping = list(value = "value")
#   )

## ----hexbin, eval = FALSE-----------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "hexbin",
#     color = "steelblue",
#     label = "hexbin",
#     data = mtcars,
#     mapping = list(x_var = "wt", y_var = "mpg", radius = 20)
#   )

## ----treemap, eval = FALSE----------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "treemap",
#     label = "cars",
#     data = mtcars,
#     mapping = list(level_1 = "vs", level_2 = "cyl")
#   )

## ----heatmap, eval = FALSE----------------------------------------------------
# df <- expand.grid(
#   quarter = c("Q1", "Q2", "Q3", "Q4"),
#   segment = c("Low", "Mid", "High"),
#   stringsAsFactors = FALSE
# )
# df$value <- c(2, 4, 6, 5, 7, 9, 4, 6, 8, 3, 5, 7)
# 
# myIO() |>
#   addIoLayer(
#     type = "heatmap",
#     color = "#4E79A7",
#     label = "Revenue",
#     data = df,
#     mapping = list(x_var = "quarter", y_var = "segment", value = "value")
#   ) |>
#   defineCategoricalAxis(xAxis = TRUE, yAxis = TRUE) |>
#   setAxisFormat(xLabel = "Quarter", yLabel = "Segment")

## ----calendar-heatmap, eval = FALSE-------------------------------------------
# set.seed(42)
# df <- data.frame(
#   day     = as.Date("2026-01-01") + 0:364,
#   commits = rpois(365, lambda = 3)
# )
# 
# myIO() |>
#   addIoLayer(
#     type = "calendarHeatmap",
#     color = "#4E79A7",
#     label = "Daily commits",
#     data = df,
#     mapping = list(date = "day", value = "commits")
#   )

## ----candlestick, eval = FALSE------------------------------------------------
# df <- data.frame(
#   day = 1:10,
#   open  = c(10, 12, 11, 14, 13, 15, 14, 16, 15, 17),
#   high  = c(14, 15, 14, 17, 16, 18, 17, 19, 18, 20),
#   low   = c(9,  11, 10, 13, 12, 14, 13, 15, 14, 16),
#   close = c(12, 11, 14, 13, 15, 14, 16, 15, 17, 19)
# )
# 
# myIO() |>
#   addIoLayer(
#     type = "candlestick",
#     label = "Price",
#     data = df,
#     mapping = list(
#       x_var = "day", open = "open",
#       high = "high", low = "low", close = "close"
#     )
#   ) |>
#   setAxisFormat(xAxis = ".0f", yAxis = "$,.0f",
#                 xLabel = "Day", yLabel = "Price")

## ----waterfall, eval = FALSE--------------------------------------------------
# df <- data.frame(
#   step  = c("Revenue", "COGS", "Gross Profit", "OpEx", "Net Income"),
#   value = c(500, -200, NA, -150, NA),
#   is_total = c(FALSE, FALSE, TRUE, FALSE, TRUE)
# )
# 
# myIO() |>
#   addIoLayer(
#     type = "waterfall",
#     label = "P&L",
#     data = df,
#     mapping = list(x_var = "step", y_var = "value", total = "is_total")
#   ) |>
#   defineCategoricalAxis(xAxis = TRUE) |>
#   setAxisFormat(yAxis = "$,.0f", xLabel = "Step", yLabel = "Amount")

## ----sankey, eval = FALSE-----------------------------------------------------
# df <- data.frame(
#   source = c("Budget", "Budget", "Sales", "Sales", "Marketing"),
#   target = c("Sales", "Marketing", "Revenue", "Leads", "Leads"),
#   value  = c(40, 20, 30, 10, 15)
# )
# 
# myIO() |>
#   addIoLayer(
#     type = "sankey",
#     color = c("#4E79A7", "#F28E2B", "#E15759", "#76B7B2", "#59A14F"),
#     label = "Flow",
#     data = df,
#     mapping = list(source = "source", target = "target", value = "value")
#   )

## ----boxplot, eval = FALSE----------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "boxplot",
#     color = "#4E79A7",
#     label = "Sepal Length",
#     data = iris,
#     mapping = list(x_var = "Species", y_var = "Sepal.Length"),
#     options = list(showOutliers = TRUE)
#   ) |>
#   setAxisFormat(xLabel = "Species", yLabel = "Sepal Length (cm)")

## ----violin, eval = FALSE-----------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "violin",
#     color = "#59A14F",
#     label = "Distribution",
#     data = iris,
#     mapping = list(x_var = "Species", y_var = "Sepal.Length"),
#     options = list(showBox = TRUE, showMedian = TRUE)
#   ) |>
#   setAxisFormat(xLabel = "Species", yLabel = "Sepal Length (cm)")

## ----ridgeline, eval = FALSE--------------------------------------------------
# df <- mtcars
# df$cyl <- as.character(df$cyl)
# 
# myIO() |>
#   addIoLayer(
#     type = "ridgeline",
#     color = c("#4E79A7", "#F28E2B", "#E15759"),
#     label = "MPG by Cylinders",
#     data = df,
#     mapping = list(x_var = "hp", y_var = "mpg", group = "cyl"),
#     options = list(overlap = 0.5)
#   ) |>
#   setAxisFormat(xLabel = "Horsepower", yLabel = "Density")

## ----qq, eval = FALSE---------------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "qq",
#     color = "#4E79A7",
#     label = "MPG Normality",
#     data = mtcars,
#     mapping = list(y_var = "mpg")
#   ) |>
#   setAxisFormat(xLabel = "Theoretical Quantiles", yLabel = "Sample Quantiles")

## ----comparison, eval = FALSE-------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "comparison",
#     color = "#4E79A7",
#     label = "Species Comparison",
#     data = iris,
#     mapping = list(x_var = "Species", y_var = "Sepal.Width"),
#     options = list(method = "t.test", p_adjust = "bonferroni")
#   ) |>
#   setAxisFormat(xLabel = "Species", yLabel = "Sepal Width (cm)")

## ----bracket, eval = FALSE----------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "boxplot", color = "#4E79A7",
#     label = "Sepal Width", data = iris,
#     mapping = list(x_var = "Species", y_var = "Sepal.Width")
#   ) |>
#   addIoLayer(
#     type = "bracket", label = "Tests",
#     transform = "pairwise_test", data = iris,
#     mapping = list(x_var = "Species", y_var = "Sepal.Width"),
#     options = list(method = "wilcox.test", p_adjust = "holm")
#   )

## ----combined, eval = FALSE---------------------------------------------------
# myIO() |>
#   addIoLayer(
#     type = "point",
#     color = "steelblue",
#     label = "points",
#     data = mtcars,
#     mapping = list(x_var = "wt", y_var = "mpg")
#   ) |>
#   addIoLayer(
#     type = "line",
#     color = "orange",
#     label = "line",
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

