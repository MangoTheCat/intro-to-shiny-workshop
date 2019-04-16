# This script contains *several* shiny apps
# To run a single app, highlight its code and Ctrl-Enter. 
# "Run App" will only run the final app at the bottom of this script

library(shiny)

# -------------------------- Defining Inputs -----------------------------------
help(sliderInput)
sliderInput(inputId = "slider", label = "Pick a number",
            min = 1, max = 10, value = 5)

help(sliderInput)

# --------------------------- Rendering Text -----------------------------------

library(shiny)
ui <- fluidPage(
  h4("String output using renderText > textOutput"),
  textOutput("strRenderText1"),
  
  h4("String ouput using renderText > verbatimTextOutput"),
  verbatimTextOutput("strRenderText2"),
  
  h4("String ouput using renderPrint > textOutput"),
  textOutput("strRenderPrint1"),
  
  h4("String ouput using renderPrint > verbatimTextOutput"),
  verbatimTextOutput("strRenderPrint2"),
  
  hr(), # Horizontal Rule to divide the page
  
  h4("T-test output using renderPrint > textOutput"),
  textOutput("ttRenderPrint1"),
  
  h4("T-test output using renderPrint > verbatimTextOutput"),
  verbatimTextOutput("ttRenderPrint2")
)
server <- function(input, output) {
  # Strings
  txt <- "Hello Shiny"
  output$strRenderText1 <- renderText({txt})
  output$strRenderText2 <- renderText({txt})
  output$strRenderPrint1 <- renderPrint({txt})
  output$strRenderPrint2 <- renderPrint({txt})
  # Model outputs
  tt <- t.test(rnorm(100))
  output$ttRenderPrint1 <- renderPrint({tt})
  output$ttRenderPrint2 <- renderPrint({tt})
}
shinyApp(ui, server)

# --------------------------- Rendering Data -----------------------------------

library(shiny)
ui <- fluidPage(
  h3("Rendering Data"),
  dataTableOutput("dfHead")
)
server <- function(input, output) {
  myDf <- data.frame(X = 1:10, Y = 1:10, Z = LETTERS[1:10] )
  output$dfHead <- renderDataTable({myDf})
}
shinyApp(ui, server)

# -------------------------- Rendering Images ----------------------------------

library(shiny)
ui <- fluidPage(
  h3("Rendering Images"),
  sliderInput(inputId = "n", label = "Number of Values", 1, 100, 25),
  imageOutput("thePlot"),
  imageOutput("mangoLogo")
)
server <- function(input, output) {
  # render existing image (from working directory)
  output$mangoLogo <- renderImage({list(src = "mango_logo.png")},
                                  deleteFile = FALSE)
  # render an image created on the fly
  output$thePlot <- renderImage({
    outfile <- tempfile(fileext = '.png')
    png(outfile, width = 400 , height = 400)
    hist(rnorm(input$n), col = "orange", main = outfile, cex.main = .75)
    dev.off()
    list(src = outfile, alt = "I just created this plot")
  }, deleteFile = TRUE)
}
shinyApp(ui, server)

# -------------------------- Rendering Plots -----------------------------------

library(shiny)
ui <- fluidPage(
  h3("Rendering Plots"),
  sliderInput(inputId = "n", label = "Number of Values", 1, 100, 25),
  plotOutput("thePlot")
)
server <- function(input, output) {
  output$thePlot <- renderPlot({ 
    hist(rnorm(input$n), col = "orange") 
  })  
}
shinyApp(ui, server)
