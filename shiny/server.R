source("visualization/utils.R")
source("visualization/static_plot.R")
source("visualization/time_animation.R")
source("visualization/time_trend.R")

library(shiny)

server <- function(input, output, session) {
  output$plot <- reactivePlot(function() {
    static.heatmap(date.sample = input$date, date.compare = NULL)
  })
}