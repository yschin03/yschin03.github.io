# Load the necessary libraries
library(shiny)
library(dplyr)

# Assuming df is a dataframe with a column 'year'
df <- df %>%
  arrange(desc(year)) # Arrange years in descending order

# Define the UI
ui <- fluidPage(
  titlePanel("Song Data by Year"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "year_select",
                  label = "Select Year",
                  choices = unique(df$year))
    ),
    mainPanel(
      tableOutput("song_table")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  output$song_table <- renderTable({
    df %>%
      filter(year == input$year_select) %>%
      select(artist, song, explicit, popularity, speechiness, tempo, genre)
  })
}

# Run the app
shinyApp(ui, server)