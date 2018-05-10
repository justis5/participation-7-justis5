library(shiny)
library(dplyr)
data <- read.csv("./data/james_harden.csv", stringsAsFactors = FALSE)
shinyServer(function(input, output) { 
  output$scatter <- renderPlotly({
    x <- data[[input$category]]
    y <- data[[input$stat]]
    ggplot(data, aes(x, y, color = court)) + geom_point() + coord_flip() + labs(
      x = input$category,
      y = input$stat
    )
  })
  
  output$time <- renderPlotly({
    x <- as.Date(data$game.date, "%Y-%m-%d")
    y <- data[[input$time_var]]
    ggplot(data, aes(x, y, color = court)) + geom_point() + labs(
        x = "Month",
        y = input$time_var
      )
  })
  
})
