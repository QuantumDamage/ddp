library(shiny)
# ui.R
shinyUI(fluidPage(
  titlePanel("Rpart results per various random data samples"),
  sidebarLayout(
    sidebarPanel(textOutput("seed"),
                 checkboxInput("fix.see", label = "Constant seed?", value = TRUE),
                 sliderInput("slider1", label = ("Elements"),
                             min = 1, max = 117, value = 50),
                 submitButton("Submit")
                 ),
    mainPanel(textOutput("text0"),
              plotOutput("map"),
              textOutput("text1"),
              textOutput("text2"))
  )
))
