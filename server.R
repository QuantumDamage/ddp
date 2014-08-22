library(shiny)
# server.R
## run once when server starts:
rand.int <- floor(runif(1,1,.Machine$integer.max))
library(rpart)
library(rpart.plot)
rows <- nrow(cu.summary)

shinyServer(function(input, output, session) {
  
  output$text0 <- renderText("To observe prediction dependence on number of samples
                             please pick number of samples (max number is 117) and
                             press 'Submit' button. Application will draw classification tree,
                             which will try predict price of used car. You can easily
                             observe, that if there are more samples, classification
                             tree will be more sophisticated. By default random seed for 
                             sampling is fixed, but if you like to have different seeds,
                             please uncheck 'Constant seed' box.")
  output$text1 <- renderText({paste("You have selected", input$slider1, " elements out of 117 and checked box:",
                                    input$fix.see)})
  sampledDataFrame <- reactive({
    if (!input$fix.see) {rand.int <- floor(runif(1,1,.Machine$integer.max))}
    output$seed <- renderText({rand.int})  
    set.seed(rand.int)
    sampled.df <- cu.summary[sample(x = nrow(cu.summary), size = input$slider1, 
                                    replace = FALSE), ] })
  output$map <- renderPlot({
    fit <- rpart(Price ~ Mileage + Type + Country, sampledDataFrame())
                                prp(fit)})
  output$text2 <- renderText("There are two small 'bugs': 1. Plot is redrawn only
after there is change on inputs. So if you would like to see tree for different seed,
but the same amount of data points, you have to change to other number and submit, 
and then change back and submit. 2. If you like to go back with constant seed, value of it
                             will change once again after first pushing 'Submit' button.
                             Then it will be constant.") 
  
})


