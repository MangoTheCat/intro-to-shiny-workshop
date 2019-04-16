# Chapter 4

# This script contains *several* shiny apps
# To run a single app, highlight its code and Ctrl-Enter. 
# "Run App" will only run the final app at the bottom of this script

# ----------------- Reactive Objects and Contexts ------------------------------
# Evaluating a reactive object outside of a reactive context
# Here input$sampleSize is evaluated within the reactive context
library(shiny)
ui <- fluidPage(
  numericInput("sampleSize", "Select size of data:", 
               min = 10, max = 500, value = 100),
  plotOutput("hist")
)
server <- function(input, output){
  output$hist <- renderPlot({
    data <- rnorm(input$sampleSize)  # inside renderPlot - good
    hist(data)
  })
}
shinyApp(ui, server)

# Here input$sampleSize is evaluated OUTSIDE the reactive context
# This should throw an error!
library(shiny)
ui <- fluidPage(
  numericInput("sampleSize", "Select size of data:", 
               min = 10, max = 500, value = 100),
  plotOutput("hist")
)
server <- function(input, output){
  data <- rnorm(input$sampleSize)  # no longer inside renderPlot - bad
  output$hist <- renderPlot({
    hist(data)
  })
}
shinyApp(ui, server)


# ---------------------- Creating Reactive Values ------------------------------
# What is wrong with the app below?
library(shiny)
ui <- fluidPage(
  numericInput("sampleSize", "Sample Size:", 
               min = 50, max = 150, value = 100),
  plotOutput("pairs"),
  verbatimTextOutput("summary")
)
server <- function(input, output){
  output$pairs <- renderPlot({
    pairs(iris[sample(input$sampleSize), ])
  })
  output$summary <- renderPrint({
    summary(iris[sample(input$sampleSize), ])
  })
}
shinyApp(ui, server)

# Adjusting to use a reactive expression to sample our dataset
library(shiny)
ui <- fluidPage(
  numericInput("sampleSize", "Sample Size:", 
               min = 50, max = 150, value = 100),
  plotOutput("pairs"),
  verbatimTextOutput("summary")
)
server <- function(input, output){
  getSample <- reactive({iris[sample(input$sampleSize), ]})
  output$pairs <- renderPlot({
    pairs(getSample())
  })
  output$summary <- renderPrint({
    summary(getSample())
  })
}
shinyApp(ui, server)


# ---------------------- Delaying Reactivity with eventReactive ----------------
library(shiny)
ui <- fluidPage(
  numericInput("sampleSize", "Sample Size:", 
               min = 50, max = 150, value = 100),
  actionButton(inputId = "update", label = "Update"),
  plotOutput("pairs"),
  verbatimTextOutput("summary")
)
server <- function(input, output){
  getSample <- eventReactive(input$update, {
    iris[sample(input$sampleSize), ]
  })
  
  output$pairs <- renderPlot({
    pairs(getSample())
  })
  output$summary <- renderPrint({
    summary(getSample())
  })
}
shinyApp(ui, server)
