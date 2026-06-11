## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(myIO)

## ----minimal, eval = FALSE----------------------------------------------------
# library(shiny)
# library(myIO)
# 
# ui <- fluidPage(
#   titlePanel("myIO + Shiny"),
#   myIOOutput("chart", width = "100%", height = "400px")
# )
# 
# server <- function(input, output) {
#   output$chart <- renderMyIO({
#     myIO() |>
#       addIoLayer(
#         type = "point",
#         color = "steelblue",
#         label = "scatter",
#         data = mtcars,
#         mapping = list(x_var = "wt", y_var = "mpg")
#       )
#   })
# }
# 
# shinyApp(ui, server)

## ----reactive, eval = FALSE---------------------------------------------------
# library(shiny)
# library(myIO)
# 
# ui <- fluidPage(
#   titlePanel("Reactive myIO Chart"),
#   sidebarLayout(
#     sidebarPanel(
#       selectInput("cyl", "Cylinders:",
#         choices = c("All", sort(unique(mtcars$cyl))),
#         selected = "All"
#       ),
#       selectInput("chart_type", "Chart Type:",
#         choices = c("point", "bar", "line"),
#         selected = "point"
#       )
#     ),
#     mainPanel(
#       myIOOutput("chart", height = "500px")
#     )
#   )
# )
# 
# server <- function(input, output) {
#   filtered_data <- reactive({
#     if (input$cyl == "All") mtcars else mtcars[mtcars$cyl == as.numeric(input$cyl), ]
#   })
# 
#   output$chart <- renderMyIO({
#     myIO() |>
#       addIoLayer(
#         type = input$chart_type,
#         color = "#E69F00",
#         label = "data",
#         data = filtered_data(),
#         mapping = list(x_var = "wt", y_var = "mpg")
#       ) |>
#       setAxisFormat(xLabel = "Weight (1000 lbs)", yLabel = "Miles per Gallon") |>
#       setMargin(top = 20, bottom = 70, left = 60, right = 10)
#   })
# }
# 
# shinyApp(ui, server)

## ----brush, eval = FALSE------------------------------------------------------
# library(shiny)
# library(myIO)
# 
# ui <- fluidPage(
#   titlePanel("Brush Selection"),
#   fluidRow(
#     column(8, myIOOutput("chart", height = "400px")),
#     column(4,
#       h4("Selected Points"),
#       verbatimTextOutput("selected")
#     )
#   )
# )
# 
# server <- function(input, output) {
#   output$chart <- renderMyIO({
#     myIO() |>
#       addIoLayer(
#         type = "point",
#         color = "#4E79A7",
#         label = "scatter",
#         data = mtcars,
#         mapping = list(x_var = "wt", y_var = "mpg")
#       ) |>
#       setBrush() |>
#       setAxisFormat(xLabel = "Weight", yLabel = "MPG")
#   })
# 
#   output$selected <- renderPrint({
#     brushed <- input$`myIO-chart-brushed`
#     if (is.null(brushed)) return("Drag to select points")
#     sel <- jsonlite::fromJSON(brushed)
#     if (length(sel$keys) == 0) return("No points selected")
#     paste(length(sel$keys), "points selected")
#   })
# }
# 
# shinyApp(ui, server)

## ----annotate, eval = FALSE---------------------------------------------------
# library(shiny)
# library(myIO)
# 
# ui <- fluidPage(
#   titlePanel("Data Annotation"),
#   fluidRow(
#     column(8, myIOOutput("chart", height = "400px")),
#     column(4,
#       h4("Annotations"),
#       tableOutput("annotations")
#     )
#   )
# )
# 
# server <- function(input, output) {
#   output$chart <- renderMyIO({
#     myIO() |>
#       addIoLayer(
#         type = "point",
#         color = "#4E79A7",
#         label = "scatter",
#         data = mtcars,
#         mapping = list(x_var = "wt", y_var = "mpg")
#       ) |>
#       setAnnotation(
#         labels = c("outlier", "interesting", "normal"),
#         colors = c(outlier = "#E63946", interesting = "#F4A261", normal = "#2A9D8F")
#       ) |>
#       setAxisFormat(xLabel = "Weight", yLabel = "MPG")
#   })
# 
#   output$annotations <- renderTable({
#     ann <- input$`myIO-chart-annotated`
#     if (is.null(ann)) return(data.frame())
#     parsed <- jsonlite::fromJSON(ann)
#     if (length(parsed$annotations) == 0) return(data.frame())
#     parsed$annotations[, c("label", "x", "y", "category")]
#   })
# }
# 
# shinyApp(ui, server)

## ----linked, eval = FALSE-----------------------------------------------------
# library(shiny)
# library(myIO)
# library(crosstalk)
# 
# ui <- fluidPage(
#   titlePanel("Linked Brushing"),
#   fluidRow(
#     column(6, myIOOutput("scatter1", height = "350px")),
#     column(6, myIOOutput("scatter2", height = "350px"))
#   )
# )
# 
# server <- function(input, output) {
#   shared <- crosstalk::SharedData$new(mtcars, key = ~rownames(mtcars))
# 
#   output$scatter1 <- renderMyIO({
#     myIO() |>
#       addIoLayer(
#         type = "point",
#         color = "#4E79A7",
#         label = "wt vs mpg",
#         data = shared$data(),
#         mapping = list(x_var = "wt", y_var = "mpg")
#       ) |>
#       setBrush() |>
#       setLinked(shared, mode = "source") |>
#       setAxisFormat(xLabel = "Weight", yLabel = "MPG")
#   })
# 
#   output$scatter2 <- renderMyIO({
#     myIO() |>
#       addIoLayer(
#         type = "point",
#         color = "#E15759",
#         label = "hp vs mpg",
#         data = shared$data(),
#         mapping = list(x_var = "hp", y_var = "mpg")
#       ) |>
#       setLinked(shared, mode = "target") |>
#       setAxisFormat(xLabel = "Horsepower", yLabel = "MPG")
#   })
# }
# 
# shinyApp(ui, server)

## ----slider, eval = FALSE-----------------------------------------------------
# library(shiny)
# library(myIO)
# 
# ui <- fluidPage(
#   titlePanel("Interactive Regression"),
#   myIOOutput("chart", height = "450px")
# )
# 
# server <- function(input, output) {
#   output$chart <- renderMyIO({
#     ci <- input$`myIO-chart-slider-ci_level` %||% 0.95
# 
#     myIO(data = mtcars) |>
#       addIoLayer(
#         type = "regression",
#         label = "fit",
#         mapping = list(x_var = "wt", y_var = "mpg"),
#         options = list(method = "lm", showCI = TRUE, level = ci)
#       ) |>
#       setSlider("ci_level", "Confidence Level", 0.80, 0.99, ci, 0.01) |>
#       setAxisFormat(xLabel = "Weight", yLabel = "MPG")
#   })
# }
# 
# shinyApp(ui, server)

## ----multiple, eval = FALSE---------------------------------------------------
# library(shiny)
# library(myIO)
# 
# ui <- fluidPage(
#   titlePanel("Multiple Charts"),
#   fluidRow(
#     column(6, myIOOutput("scatter", height = "350px")),
#     column(6, myIOOutput("bars", height = "350px"))
#   )
# )
# 
# server <- function(input, output) {
#   output$scatter <- renderMyIO({
#     myIO() |>
#       addIoLayer(
#         type = "point",
#         color = "#56B4E9",
#         label = "scatter",
#         data = mtcars,
#         mapping = list(x_var = "wt", y_var = "mpg")
#       ) |>
#       setAxisFormat(xLabel = "Weight", yLabel = "MPG")
#   })
# 
#   output$bars <- renderMyIO({
#     myIO() |>
#       addIoLayer(
#         type = "bar",
#         color = "#E69F00",
#         label = "bars",
#         data = mtcars,
#         mapping = list(x_var = "cyl", y_var = "mpg")
#       ) |>
#       defineCategoricalAxis(xAxis = TRUE) |>
#       setAxisFormat(xLabel = "Cylinders", yLabel = "MPG")
#   })
# }
# 
# shinyApp(ui, server)

## ----themed, eval = FALSE-----------------------------------------------------
# library(shiny)
# library(myIO)
# 
# ui <- fluidPage(
#   style = "background-color: #1a1a2e; color: #e0e0e0;",
#   titlePanel("Dark Mode Dashboard"),
#   myIOOutput("chart", height = "400px")
# )
# 
# server <- function(input, output) {
#   output$chart <- renderMyIO({
#     myIO() |>
#       addIoLayer(
#         type = "line",
#         color = c("#48dbfb", "#ff6b6b", "#feca57", "#ff9ff3", "#00d2ff"),
#         label = "Month",
#         data = within(airquality, Month <- paste0("M", Month)),
#         mapping = list(x_var = "Day", y_var = "Temp", group = "Month")
#       ) |>
#       setTheme(
#         text_color = "#b0b0b0",
#         grid_color = "#2d2d2d",
#         bg = "#1a1a2e",
#         font = "Inter, system-ui, sans-serif"
#       ) |>
#       setAxisFormat(xLabel = "Day", yLabel = "Temperature")
#   })
# }
# 
# shinyApp(ui, server)

## ----sizing, eval = FALSE-----------------------------------------------------
# # Fixed size
# myIOOutput("chart1", width = "600px", height = "400px")
# 
# # Fill container width
# myIOOutput("chart2", width = "100%", height = "500px")

