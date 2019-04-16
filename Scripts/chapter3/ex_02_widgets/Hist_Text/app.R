library(shiny)
ui <- fluidPage(
  sliderInput("numberOfSims", label = "Enter number of values:",
              min = 1, max = 500, value = 100),
  selectInput("colour", label = "Select plot colour:", 
              choices = c("red", "yellow", "green", "blue", "purple")),
  textInput("title", label = "Enter title:", value = "Histogram of data"),
  checkboxInput("meanLine", "Show median line"),
  
  plotOutput(outputId = "simHist"),
  verbatimTextOutput(outputId = "summary")
)
server <- function(input, output){
  output$simHist <- renderPlot({
    normData <- rnorm(input$numberOfSims)
    hist(normData, col = input$colour, main = input$title)
    if (input$meanLine) abline(v = median(normData))
  })
  output$summary <- renderText({
    paste0("hist(normData, col =", input$colour, 
           ", main = ", input$title, ")")
  })
}
shinyApp(ui, server)
