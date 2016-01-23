
# Initialize
library(shiny)
library(quantmod)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Reactively Pull Stock Data
  stockdata <- reactive({
    getSymbols(input$ticker, from = input$dates[1], to = input$dates[2], auto.assign = FALSE)
  })
  
  # Output Plot
  output$chart <- renderPlot({
    chartSeries(stockdata())
    switch(input$indic,
      "SMA" = addSMA(input$days),
      "EMA" = addEMA(input$days),
      "Aroon" = addAroon(input$days),
      "AroonOsc" = addAroonOsc(input$days)
    )
  })
  
  # Download File
  output$download <- downloadHandler(filename = function() {paste(input$ticker,"csv", sep = ".")},
                                     content = function(file){write.csv(stockdata(), file)})
  
  # Set header
  output$ticker <- renderText(paste("Chart for:",input$ticker))
  

})