# Load the necessary libraries
library(shiny)
library(ggplot2)
library(tidyverse)
library(bslib)



#load datasets
df<- read_csv("df.csv")
df$speechiness <- as.numeric(df$speechiness)
df$tempo <- as.numeric(df$tempo)
df$loudness <- as.numeric(df$loudness)
df$acousticness <- as.numeric(df$acousticness)
df$loudness <- as.numeric(df$valence)

# Define the UI
ui <- fluidPage(
  # Add a navbarPage to create multiple tabs
  navbarPage(title = "Scatterplot",
                      # Create the first tab
                      tabPanel("Effect of Speechiness on Popularity", title = "Speechiness", plotOutput("scatter1", width ="75%", height = "400px")),
                      # Create the second tab
                      tabPanel("Effect of Tempo on Popularity", title = "Tempo", plotOutput("scatter2", width ="75%", height = "400px")),
                      # Create the third tab
                      tabPanel("Effect of Loudness on Popularity", title = "Loudness", plotOutput("scatter3", width ="75%", height = "400px")),
                      # Create the fourth tab
                      tabPanel("Effect of Acousticness on Popularity", title = "Acousticness", plotOutput("scatter4", width ="75%", height = "400px")),
                      # Create the fifth tab
                      tabPanel("Effect of Valence on Popularity", title = "Valence", plotOutput("scatter5", width ="75%", height = "400px"))
             )
  )

# Define the server logic
server <- function(input, output) {
  # Input your scatter plot code for each plot below
  output$scatter1 <- renderPlot({
    ggplot(df, aes(x = speechiness, y = popularity, color = speechiness)) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      scale_color_gradient2(low = "darkblue", mid = "mediumpurple", high = "red",
                            midpoint = median(df$speechiness), space = "Lab") +
      theme_minimal() +
      theme(legend.position = "right") +
      labs(title = "Speechiness Versus Popularity",
           x = "Speechiness",
           y = "Popularity")
    
  })
  
  output$scatter2 <- renderPlot({
    ggplot(df, aes(x = tempo, y = popularity, color = tempo)) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      scale_color_gradient2(low = "darkblue", mid = "mediumpurple", high = "red",
                            midpoint = median(df$tempo), space = "Lab") +
      theme_minimal() +
      theme(legend.position = "right") +
      labs(title = "Tempo Versus Popularity",
           x = "Tempo",
           y = "Popularity")
  })
  
  output$scatter3 <- renderPlot({
    ggplot(df, aes(x = loudness, y = popularity, color = loudness)) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      scale_color_gradient2(low = "darkblue", mid = "mediumpurple", high = "red",
                            midpoint = median(df$loudness), space = "Lab") +
      theme_minimal() +
      theme(legend.position = "right") +
      labs(title = "Loudness Versus Popularity",
           x = "Loudness",
           y = "Popularity")
  })
  
  output$scatter4 <- renderPlot({
    ggplot(df, aes(x = acousticness, y = popularity, color = acousticness)) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      scale_color_gradient2(low = "#000033", mid = "mediumpurple", high = "red",
                            midpoint = median(df$acousticness), space = "Lab") +
      theme_minimal() +
      theme(legend.position = "right") +
      labs(title = "Acousticness Versus Popularity",
           x = "Acousticness",
           y = "Popularity")
  })
  
  output$scatter5 <- renderPlot({
    ggplot(df, aes(x = valence, y = popularity, color = valence)) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      scale_color_gradient2(low = "darkblue", mid = "mediumpurple", high = "red",
                            midpoint = median(df$valence), space = "Lab") +
      theme_minimal() +
      theme(legend.position = "right") +
      labs(title = "Valence Versus Popularity",
           x = "Valence",
           y = "Popularity")
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)