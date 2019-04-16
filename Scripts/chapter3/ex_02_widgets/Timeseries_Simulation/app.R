library(shiny)
ui <- fluidPage(
  dateRangeInput("dateRange", "Select start and end dates:"),
  radioButtons("distribution", "Select distribution:",
               choices = c("Normal", "Poisson", "Uniform")),
  plotOutput(outputId = "datePlot")
)
server <- function(input, output){
  
  output$datePlot <- renderPlot({
    dates <- seq(input$dateRange[1], input$dateRange[2], by = "day")
    nDates <- length(dates)
    simData <- switch(input$distribution,
                      "Normal" = rnorm(nDates),
                      "Uniform" = runif(nDates),
                      "Poisson" = rpois(nDates, lambda = 5))
    plot(dates, simData, type = "l")
  })
}
shinyApp(ui, server)
