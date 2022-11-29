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

    # Application title
    titlePanel("A5: Differential Impacts of CO2 Emissions"),

    #Part 1: Introduction
    h1("Part 1: Introduction"),
    
    #Variable 1 Question
    h2("In what year was C02 the highest?"),
    
    #Variable 1 Answer
    h3("2021"),
    
    #Variable 2 Question
    
    h2("What is the average C02 across all countries in 2021?"),
    
    #Variable 2 Answer
    
    h3("970.2002"),
    
    #Variable 3 Question
    h2("What country has the highest proportion of co2 to population ratio as of most recent (2021)?"),
    
    #Variable 3 Answer
    h3("Qatar")))
    
    
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
