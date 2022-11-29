Climate_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

library(shiny)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(plotly)
library(stringr)
library(lintr)


server <- function(input, output) {
  output$summary_value1 <- renderText({
    Highest_CO2 <- Climate_data %>% 
      filter(co2 == max(co2,na.rm=TRUE)) %>% 
      pull(year)
  })
  
  output$summary_value2 <- renderText({
    Average_CO2 <- Climate_data %>% 
      group_by(year) %>% 
      filter(year==2021) %>% 
      summarize(co2 = mean(co2, na.rm=TRUE)) %>% 
      pull(co2)
    
  })
  
  output$summary_value3 <- renderText({
    Max_ratio_co2_to_pop <- Climate_data %>% 
      filter(year==2021) %>% 
      mutate(co2_to_pop = co2/population) %>% 
      filter(co2_to_pop== max(co2_to_pop, na.rm=TRUE)) %>% 
      pull(country)
  })
  
  #plot
  output$scatter_plot <- renderPlotly ({
    plot_data <- Climate_data %>% 
      filter(country %in% input$country_pick, year <= input$year)
    
    plot <- plot_ly(plot_data,
                    x=~co2_per_capita,
                    y=~co2_per_gdp, 
                    type= "scatter", 
                    mode="markers", 
                    color= ~country, 
                    marker= list(size = 15), 
                    text= ~paste(plot_data$country, "<b>",plot_data$year, "<br>"),
                    hoverinfo = "text") %>%  
                  layout(title = "CO2 per Capita vs CO2 per GDP", xaxis = list(title = "CO2 per Capita (Tonnes per Person)"), yaxis= list(title = "CO2 per GDP (Tonnes per GDP)"))
                    
                    return(plot)
  })
}
  
