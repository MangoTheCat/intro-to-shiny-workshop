library(shiny)
# Define the user interface component
ui <- fluidPage(
  sliderInput(inputId = "bins", label = "Number of bins:",
              min = 1, max = 50, value = 30),
  plotOutput(outputId = "hist")
)

# Define the server component
server <- function(input, output) {
  output$hist <- renderPlot({
    x <- faithful$waiting
    binBreaks <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = binBreaks)
  })
}
# Combine the two components
shinyApp(ui = ui, server = server)
