library(shiny)
# Define the user interface component
ui <- fluidPage(
  sliderInput(inputId = "bins", label = "Number of bins:",
              min = 20, max = 40, value = 30),
  sliderInput(inputId = "colour", label = "Colour:",
              min = 1, max = 10, value = 1),
  plotOutput(outputId = "hist")
)

# Define the server component
server <- function(input, output) {
  output$hist <- renderPlot({
    x <- faithful$eruptions
    binBreaks <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = binBreaks, col = input$colour)
  })
}
# Combine the two components
shinyApp(ui = ui, server = server)
