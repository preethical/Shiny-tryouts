#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(data.table)
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)

shinyServer(function(input, output){
    
    Data_subset <- reactive({
        a <- timeseries_melt %>% filter(Sectors == input$sector & State == input$state)
        return(a)
        })
    
    ##Fill in the spot we created for a plot
    output$timeplot <- renderPlot({
                ##Render a time-seriesplot
            ggplot (data = Data_subset(),aes(x = year, y = value, group = Sectors, color = Sectors)) + 
            geom_point(size=3) + geom_line (size = 1)+ scale_y_continuous(labels = scales::comma)+ 
            theme(axis.text.x = element_text(angle = 90, hjust = 1))+ 
            xlab("year") + ylab("Budget in lakhs")+
            guides(size = FALSE)+
            theme(plot.margin = margin(2,.8,2,.8, "cm"))
        })
   
    })



