setwd("../..")
source("visualization/utils.R")
source("visualization/static_plot.R")
source("visualization/time_animation.R")
source("visualization/time_trend.R")

library(shiny)


date <- read.csv(cache.all.file.path)$date %>% unique

ui <- fluidPage(
  headerPanel("WT Data Project"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput("date", "Date:", date)
    ),
    mainPanel = mainPanel(
      plotOutput("plot", height = 600, width = 525)
    )
  )
)

