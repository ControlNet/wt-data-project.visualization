setwd("../..")
source("visualization/utils.R")
source("visualization/static_plot.R")
source("visualization/time_animation.R")
source("visualization/time_trend.R")

library(shiny)
library(plotly)
library(DT)


date <- read.csv(cache.all.file.path)$date %>% unique
cls <- c("Ground_vehicles", "Aviation")
fill <- c("rb_win_rate", "rb_battles_sum")

ui <- fluidPage(
  titlePanel("WT Data Project"),
  tabsetPanel(
    tabPanel("Heatmap", sidebarLayout(
      sidebarPanel = sidebarPanel(
        selectInput("heatmap_date", "Date:", date, selected = date[1]),
        selectInput("heatmap_cls", "Class:", cls, selected = cls[1]),
        selectInput("heatmap_fill", "Measurement:", fill, selected = fill[1]),
        width = 2
      ),
      mainPanel = mainPanel(
        plotlyOutput("heatmap", height = 600, width = 800))
      )
    ),
    tabPanel("Table", sidebarLayout(
      sidebarPanel = sidebarPanel(
        selectInput("table_date", "Date:", date, selected = date[1]),
        selectInput("table_cls", "Class:", cls, selected = cls[1]),
        selectInput("table_nation", "Nation:", nation_order, selected = nation_order[1]),
        width = 2
      ),
      mainPanel = mainPanel(
        tableOutput("table")
      )
    ))
  )
)
