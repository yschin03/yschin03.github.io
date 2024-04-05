library(shiny)
library(tidyverse)
df <- read_csv("df.csv")

ui <- fluidPage(
  titlePanel("Histograms of Different Song Qualities"),
  selectInput("variable", "Variable:", choices = c("Speechiness", "Tempo", "Loudness", "Acousticness", "Valence")),
  plotOutput(outputId = "histogram")
)

server <- function(input, output, session) {
  output$histogram <- renderPlot({
    switch(input$variable,
           "Speechiness" = ggplot(df, aes(x=speechiness)) +
             geom_histogram(binwidth=0.01, fill="#BA110C", color="black") +
             labs(x="Speechiness", y="Count", title="Distribution of Song Speechiness"),
           "Tempo" = ggplot(df, aes(x=tempo)) +
             geom_histogram(binwidth=3, fill="skyblue", color="black") +
             labs(x="Tempo", y="Count", title="Distribution of Song Tempo"),
           "Loudness" = ggplot(df, aes(x=loudness)) +
             geom_histogram(binwidth=0.5, fill="blue", color="black") +
             labs(x="Loudness", y="Count", title="Distribution of Song Loudness"),
           "Acousticness" = ggplot(df, aes(x=acousticness)) +
             geom_histogram(binwidth=0.03, fill="darkgreen", color="black") +
             labs(x="Acousticness", y="Count", title="Distribution of Song Acousticness"),
           "Valence" = ggplot(df, aes(x=valence)) +
             geom_histogram(binwidth=0.025, fill= "mediumpurple" , color="black") +
             labs(x="Valence", y="Count", title="Distribution of Song Valence")
    )
  })
}

shinyApp(ui, server)