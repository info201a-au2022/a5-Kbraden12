library(plotly)
library(stringr)

Climate_data <- read.csv("../Data/owid-co2-data.csv")

#First Page
intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    h2("Introduction to CO2 Emmissions Analysis Application"),
    p("This report is intended to investigate CO2 emissions and how they disproportionately affect different groups
      of people based on various factors such as income or geography. To begin, I have analyzed the CO2 emissions data
      set to derive three important variables that might reveal any important insights, patterns, or trends regarding CO2 emissions from
      the data. The first variable I was interested in deriving was in which year was CO2 the highest? This was interesting
      to me because I know CO2 emissions tend to get higher as the years go by. Another variable I was interested in calculating was 
      what is the average CO2 level across all countries in 2021? I know that CO2 emissions are very high these days so I was interested to
      see exatcly what there average level was as of most recent. The final variable I was interested in calculating was what country
      had the highest proportion of CO2 to population ratio as of most recent? This was an interesting variable to calculate
      because I wanted to analyze what country emits the most CO2 given the amount of people they have living in their country."),
    h2("Summary Values"),
    p("Summary Value #1: In what year was C02 the highest?"),
    p(textOutput("summary_value1")),
    p("Summary Value #2: What is the average C02 (in tonnes) across all countries in 2021?"),
    p(textOutput("summary_value2")),
    p("Summary Value #3: What country has the highest proportion of co2 to population ratio as of most recent (2021)?"),
    p(textOutput("summary_value3"))
    
  )
)

unique_country <- unique(Climate_data$country)

grouped_data <- Climate_data %>% 
  group_by(country) %>% 
  summarize(count= n())

count_range <- range(grouped_data$country)

##Data needed for input widgets

year_range <- range(Climate_data$year)

country_unique <- unique(Climate_data$country)


#Second page
country_pick <- selectInput(inputId= "country_pick",
                            label = "Select Country", 
                            choices = Climate_data$country,
                            selected = country_unique[1],
                            multiple = TRUE)

year_slider <- sliderInput(inputId = "year",
                           label = "Year Range", sep="",
                           min = min(Climate_data$year),
                           max = max(Climate_data$year),
                           value = c(2000, 2020))


#UI Pages

ui <- fluidPage(h1(strong("CO2 Emissions"),
                   style = "color: Blue"),
                
                tabsetPanel(
                  tabPanel("Introduction", intro_tab),
                  tabPanel("Global Share of CO2 Emissions",
                           fluidRow(
                             column(country_pick, width = 6),
                             column(year_slider, width = 6)
                           ),
                           fluidRow(
                             column(plotlyOutput("scatter_plot"), width = 12)
                           ),
                           p("This chart reveals the relationship between the CO2 emimissions per capita and the CO2 emissions
                             per GDP of a given country in a given year. Essentially this chart is showing the relationship between 
                             CO2 levels and how it is influenced by the population and economic status of a given country in a given
                             year. For the most part, there is a positive correlation between the population and GDP of a particular 
                             country in a given year and the effect it has on CO2 emmissions."), align="center")
                ))

