#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(tidyverse)
library(ggplot2)

Climate_data <- read.csv("C:/Users/katie/Documents/info201/assignments/a5-Kbraden12/Data/owid-co2-data.csv")
View(Climate_data)

#Part 1: Introduction

#Variable 1: In what year was C02 the highest?

Highest_CO2 <- Climate_data %>% 
  filter(co2 == max(co2,na.rm=TRUE)) %>% 
  pull(year)

Highest_CO2

#Variable 2: What is the average C02 across all countries in 2021?


Average_CO2 <- Climate_data %>% 
  group_by(year) %>% 
  filter(year==2021) %>% 
  summarize(co2 = mean(co2, na.rm=TRUE)) %>% 
  pull(co2)

Average_CO2


#Variable 3: What country has the highest proportion of co2 to population ratio as of most recent (2021)?


Max_ratio_co2_to_pop <- Climate_data %>% 
  filter(year==2021) %>% 
  mutate(co2_to_pop = co2/population) %>% 
  filter(co2_to_pop== max(co2_to_pop, na.rm=TRUE)) %>% 
  pull(country)

Max_ratio_co2_to_pop



server <- function(input, output) {
  output$co2Plot <- renderPlotly({
    Climate_data <- Climate_data %>%  filter(country %in% input$user_category)
    
    co2_plot <- ggplot(data = Climate_data) +
      geom_line(mapping = aes(x= year, y= co2, color=country)) +
      geom_line(mapping = aes(x=year, y= gdp, color=country)) +
      labs(title= "CO2 vs GDP per Country", x= "Year", y= "Tons of ")
      
  }
    )
}


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')

    })

})
