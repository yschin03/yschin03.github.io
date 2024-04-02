# Load necessary libraries
library(shiny)

# Define the UI
ui <- fluidPage(titlePanel("Bar Plot"),
                sidebarLayout(
                  position = "left",
                  sidebarPanel(
                        sliderInput(inputId = "bins",
                                    label = "Number of bins:",
                                    min = 1,
                                    max = 50,
                                    value = 30)
                        
                      ),
                  mainPanel(plotOutput(outputId = "barPlot"))
                )
)

# Define server logic ----
server <- function(input, output) {
  data <- reactive({
    df
  })
  
  # Create the bar plot using the selected variables
  output$barPlot <- renderPlot({
    ggplot(df, aes(x = genre)) +
      geom_bar()
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)