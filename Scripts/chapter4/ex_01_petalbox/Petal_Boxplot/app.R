library(shiny)
ui <- fluidPage(
  textInput("title", "Title:", value = "Petal Length from sampled iris."),
  numericInput("sampleSize", "Select size of data:", 
               min = 50, max = 150, value = 100),
  selectInput("colour", "Select a colour",
              choices = c("orange", "blue", "green")),
  checkboxInput("horizontal", "Horizontal?", value = FALSE),
  submitButton(text = "Update Plot"),
  plotOutput("bplot")
)
server <- function(input, output){
  output$bplot <- renderPlot({
    samp <- iris[sample(input$sampleSize), ]
    boxplot(Petal.Length ~ Species, data = samp,
            col = input$colour, horizontal = input$horizontal)
  })
}
shinyApp(ui, server)
