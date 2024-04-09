library(shiny)
library(tidyverse)

original_dataset <- read_csv("songs_normalize.csv")
df <- read_csv("df.csv")

# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Viewing the Datasets "),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("Original Dataset", "Cleaned Dataset")),
      
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 30)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
    
      # Add conditional panel to display header based on selected dataset
      conditionalPanel(
        condition = "input.dataset === 'Original Dataset'",
        h1("Original Dataset"),
        h4("This dataset has a total of 2000 rows by 18 columns.")
      ),
      conditionalPanel(
        condition = "input.dataset ==='Cleaned Dataset'",
        h1("Cleaned Dataset"),
        h4("This dataset has a total of 1937 rows by 10 columns.")
      ),
      
      # Output: HTML table with requested number of observations ----
      tableOutput("view")
      
    )
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  # Return the requested dataset ----
  datasetInput <- reactive({
    switch(input$dataset,
           "Original Dataset" = original_dataset,
           "Cleaned Dataset" = df)
  })
  
  
  
  # Show the first "n" observations ----
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
