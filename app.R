#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)


birthratedata <- read.csv("NCHS_-_Teen_Birth_Rates_for_Females_by_Age_Group__Race__and_Hispanic_Origin__United_States.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Female Teen Birth Rates"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput(
           inputId = "yearInput",
           label = "Select Year",
           choices = 1960:2015
         )
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         tableOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  filtered <- reactive({
    birthratedata %>%
      filter(
        Year == input$yearInput[1]
      )
  })
  
   output$distPlot <- renderTable({
     filtered()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

