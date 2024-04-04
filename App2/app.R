# Load the tidyverse library
library(tidyverse)

# Define the UI
ui <- fluidPage(
  titlePanel("Top Artists with Most Spotify Top Tracks"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n_values", "Number of Values:", min = 1, max = 100, value = 20)
    ),
    mainPanel(
      plotOutput("bar_plot")
    )
  )
)

# Define the server function
server <- function(input, output) {
  # Load the data
  df <- read_csv("songs_normalize.csv")
  
  # Create the bar plot
  df_grouped <- reactive({
    df_grouped <- df %>%
      group_by(artist) %>%
      summarise(song = n()) %>%
      arrange(desc(song)) %>%
      head(input$n_values)
    
    df_grouped$artist <- as.character(df_grouped$artist)
    df_grouped
  })
  
  output$bar_plot <- renderPlot({
    ggplot(df_grouped(), aes(x = reorder(artist, -song), y = song, fill = "red")) +
      geom_bar(stat = "identity", width = 0.8, color = "black") +
      labs(title = "Top Artists with Most Spotify Top Tracks", x = "Artist", y = "Total Songs") +
      geom_text(aes(label = song), vjust = -0.5, size = 3) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      guides(fill = FALSE)
  })
}

# Run the Shiny app
shinyApp(ui, server)