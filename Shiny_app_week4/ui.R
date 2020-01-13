#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


shinyUI(fluidPage(

    # Application title
    titlePanel("Sector & State Wise Budget Data For India"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            helpText("Create time-series plots for Sector and State Wise Budget Data for India"),
            selectInput("sector", label="Sector", choices =  unique(timeseries_melt$Sectors), 
                        selected = "Health"),
            selectInput("state", label = "State", choices = unique(timeseries_melt$State), selected = "Assam")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("timeplot")
        )
    )
    )
)
