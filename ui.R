# ui.R
library(shiny)
library(plotly)
first_name = data$player.FirstName[[1]]
last_name = data$player.LastName[[1]]
title_name <- paste("2016-2017", first_name, last_name)
shinyUI(navbarPage(
  titlePanel(title_name),
  tabPanel(
    "Performance against Teams",
    titlePanel("Stats Across Teams"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "category",
          label = "Category",
          choices = list("Opponent" = "opponent",
                         "Game Location" = "game.location") 
            # colnames(data)[index]
        ),
        selectInput(
          "stat",
          label = "Stat to Check",
          choices = colnames(data)[9:72]
        )
          
      ), 
      mainPanel(
        plotlyOutput("scatter")
      )
    )
  ),
  tabPanel(
    "Performance across Time",
    titlePanel("Stats Across Time"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "time_var",
          label = "Stat to Check",
          choices = colnames(data)[9:72]
        )
        
      ), 
      mainPanel(
        plotlyOutput("time")
      )
    )
  )
))

