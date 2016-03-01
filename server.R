
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(scales)
library(DT)
MyFitness_data <- read.csv("./data/MyFitness_data.csv")
MyFitness_data$date<-as.Date(MyFitness_data$date)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output){
      selectedData <- reactive({
            MyFitness_data[, c(input$ycol, input$xcol)]
      })
      
      #output$value <- renderPrint({ input$dates })

     output$plot1 <- reactivePlot(function() {
           x<-MyFitness_data[,input$xcol]
           y<-MyFitness_data[,input$ycol]
           
            if (input$xcol == "Sleep.quality"){
                 sp <- ggplot(selectedData(), aes(x=x, y=y)) 
                 sp <- sp + xlab("Sleep Quality measurement in %") + ylab("Consumption in gram(g)")
                 sp <- sp + geom_point() + stat_smooth(method = lm)
                  }

            if (input$xcol == "Heart.rate"){
                 sp <- ggplot(selectedData(), aes(x=x, y=y)) 
                 sp <- sp + xlab("Heart Rate measurement in the morning") + ylab("Consumption in gram(g)")
                 sp <- sp + geom_point() + stat_smooth(method = lm)
                  }
           print(sp)
      })
      #output$plot1 <- renderPlot({
      #      x<-MyFitness_data[,input$xcol]
      #      y<-MyFitness_data[,input$ycol]
      #      sp <- ggplot(selectedData(), aes(x=x, y=y)) + ylab("Consumption in gram(g)")
      #      sp <- sp + geom_point() + stat_smooth(method = lm)
      #      print(sp)
      #)

      output$plot2 <- renderPlot({
            y <- MyFitness_data[,input$ycol]
            x <- MyFitness_data[,"date"]
            gp <- ggplot(selectedData(), aes(x=x, y=y)) + geom_point() + geom_line(colour='blue')
            gp <- gp + geom_area(fill='blue', alpha=.2) + ylab("Consumption in gram(g)") + xlab("")
            gp <- gp + scale_x_date(breaks = date_breaks("1 day"), labels = date_format("%d-%b-%Y"))
            gp <- gp+ theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 8))
            print(gp)
      }) 
      
            # Generate a table view of the dataset
      output$view <- DT::renderDataTable({
            #DT::datatable(MyFitness_data[ ,c(input$xcol,input$ycol), drop = FALSE],
            DT::datatable(MyFitness_data, options = list(pageLength = 5))
      })
      
})      