source("visualization/utils.R")
source("visualization/static_plot.R")
source("visualization/time_animation.R")
source("visualization/time_trend.R")

library(shiny)
library(plotly)

server <- function(input, output, session) {
  output$heatmap <- renderPlotly({
    colors <- reactive(c(white, black, red, yellow, green, black, black))
    colors.pos <- reactive({
      if (input$heatmap_cls == "Aviation" & input$heatmap_fill == "rb_win_rate")
        c(0, 0.01, 0.5, 0.6, 0.7, 0.99, 1.0)
      else
        c(0, 0.01, 0.4, 0.5, 0.6, 0.99, 1.0)
    })

    fill.limits <- reactive({
      if (input$heatmap_fill == "rb_win_rate")
        c(0, 100)
       else if (input$heatmap_fill == "rb_battles_sum")
        c(2.5, 5.5)
    })

    fill.log <- reactive({
      if (input$heatmap_fill == "rb_win_rate")
        FALSE
       else if (input$heatmap_fill == "rb_battles_sum")
        TRUE
    })

    static.heatmap(date.sample = input$heatmap_date,
                   date.compare = NULL,
                   class.sample = input$heatmap_cls,
                   fill = input$heatmap_fill,
                   fill.limits = fill.limits(),
                   fill.log = fill.log(),
                   colors.pos = colors.pos(),
                   colors = c(white, black, red, yellow, green, black, black)
    ) %>% ggplotly()
  })

  output$table <- renderTable({
    read.csv(cache.1.file.path("rb")) %>%
      filter(date == input$table_date) %>%
      filter(cls == input$table_cls) %>%
      filter(nation == input$table_nation)
  })
}