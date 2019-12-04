#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(  
        titlePanel("Example plot"),  
    sidebarLayout( 
        sidebarPanel(
            sliderInput("sliderMPG", "What is the mpg of the car", 10,35,value = 20),
            checkboxInput("ShowModel1","Show/hide model 1",value = TRUE),
            checkboxInput("ShowModel2","Show/hide model 2",value = TRUE)
        ),
        
     mainPanel(    
        plotOutput('plot1'),
        h3 ("Predicted HP from model 1:"),
        textOutput ("pred1"),
        h3 ("Predicted HP from model 2:"),
        textOutput ("pred2")
        )
)
))
