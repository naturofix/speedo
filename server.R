#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library('plotly')
library('htmlwidgets')
library('RCurl')

image_file <- "www/speedo.png"
txt <- RCurl::base64Encode(readBin(image_file, "raw", file.info(image_file)[1, "size"]), "txt")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  

  output$plot = renderPlotly({
    p <- plot_ly(x = c(1, 2, 3), y = c(1, 2, 3), type = 'scatter', mode = 'markers') %>%
      layout(
        images = list(
          list(
            source =  paste('data:image/png;base64', txt, sep=','),
            xref = "x",
            yref = "y",
            x = 1,
            y = 3,
            sizex = 2,
            sizey = 2,
            sizing = "stretch",
            opacity = 0.4,
            layer = "below"
          )
        )
      )
    print(p)
  })
  #htmlwidgets::saveWidget(p, "/tmp/plot.html")
  output$plot_2 = renderPlotly({
  plot_ly(x = c(1, 2, 3), y = c(1, 2, 3), type = 'scatter', mode = 'markers') %>%
    layout(
      images = list(
        list(
          source =  "https://github.com/charlottesirot/elementR/blob/master/inst/www/2.png?raw=true",
          xref = "x",
          yref = "y",
          x = 1,
          y = 3,
          sizex = 2,
          sizey = 2,
          sizing = "stretch",
          opacity = 0.4,
          layer = "above"
        )
      )
    )
  })
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
