# Using Reactive Expressions
library(shiny)
ui <- fluidPage(
  numericInput("nRands", "Number of random values:", 
               min = 10, max = 100, value = 50),
  selectInput("colour", "Select a colour",
              choices = c("orange", "blue", "green")),
  plotOutput("hist"),
  verbatimTextOutput("summary")
)
server <- function(input, output){
  getRands <- reactive({
    Sys.sleep(5)
    rnorm(input$nRands) 
  })
  output$hist <- renderPlot({
    hist(getRands(), col = input$colour) 
  })
  output$summary <- renderPrint({
    summary(getRands())
  })
}
shinyApp(ui, server)

# Changing the colour will be almost instantaneous since when renderPlot
# is called it will use the cached random values
# Changing nRands will take at least 5 seconds as the values are 
# recomputed.