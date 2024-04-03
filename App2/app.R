library(shiny)
library(tidyverse)

df <- read_csv("df.csv")

# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Viewing the Datasets "),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for choosing variable for x-axis ----
      selectInput(inputId = "x_var",
                  label = "Choose a variable for x-axis:",
                  choices = colnames(df)),
      
      # Input: Selector for choosing variable for y-axis ----
      selectInput(inputId = "y_var",
                  label = "Choose a variable for y-axis:",
                  choices = colnames(df)),
      
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 20)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Column chart with requested number of observations ----
      plotOutput("column_chart")
      
    )
  )
  
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  datasetInput <- reactive({
    df
  })
  
  # Create a column chart of the selected variables
  output$column_chart <- renderPlot({
    ggplot(datasetInput(), aes_string(x = input$x_var, y = input$y_var)) +
      geom_col() +
      labs(x = input$x_var, y = input$y_var, title = "Column Chart of Selected Variables")
  })
  
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)