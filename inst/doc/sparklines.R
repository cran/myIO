## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(myIO)

## ----basic-sparkline, eval = FALSE--------------------------------------------
# myIO(data.frame(x = 1:20, y = cumsum(rnorm(20))), sparkline = TRUE) |>
#   addIoLayer("line", label = "trend", mapping = list(x_var = "x", y_var = "y"))

## ----supported-types, eval = FALSE--------------------------------------------
# df <- data.frame(x = 1:12, y = c(4, 6, 5, 8, 7, 9, 6, 10, 8, 11, 9, 12))
# 
# # Line sparkline
# myIO(df, sparkline = TRUE) |>
#   addIoLayer("line", label = "line", mapping = list(x_var = "x", y_var = "y"))
# 
# # Bar sparkline
# myIO(df, sparkline = TRUE) |>
#   addIoLayer("bar", label = "bars", mapping = list(x_var = "x", y_var = "y"))
# 
# # Area sparkline
# myIO(df, sparkline = TRUE) |>
#   addIoLayer("area", label = "area", mapping = list(x_var = "x", y_var = "y"))

