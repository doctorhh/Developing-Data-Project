
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(ggplot2)
library(DT)
MyFitness_data <- read.csv("./data/MyFitness_data.csv")
MyFitness_data$date<-as.Date(MyFitness_data$date)

shinyUI(fluidPage(
      # Application title
      titlePanel("Self-Quantify apps"),
            sidebarPanel(
            hr(),
            selectInput('ycol', 'Macronutriment', names(MyFitness_data)[-c(1,5,6)],selected=names(MyFitness_data[[2]])),
            hr(),
            selectInput('xcol', 'Dependent', names(MyFitness_data)[-c(1,2,3,4)], selected=names(MyFitness_data[[5]])),
            hr()
      ),
      
      mainPanel(
            tabsetPanel(type = "tabs",
                  tabPanel('Regression Graphic', plotOutput("plot1")),
                  tabPanel('Hist of consumption', plotOutput("plot2")),
                  tabPanel('MyFitness dataset', DT::dataTableOutput("view")),
                  tabPanel("About",includeMarkdown("./about.md"))
                 )
            )
))
