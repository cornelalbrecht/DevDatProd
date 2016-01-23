
# Initialize
library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title
  headerPanel("Technical Stock Analyzer"),
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    h3("Ticker"),
    helpText("Enter the ticker of the stock you want to see, i.e. AMZN for Amazon or NFLX for Netflix."),
    textInput("ticker", "Ticker Symbol", value = "SPY"),
    dateRangeInput("dates", "Date Range", start = "2015-10-1", end = as.character(Sys.Date())),
    
    h3("Technical Indicators"),
    helpText("Select an indicator and a number of averaging days"),
    selectInput("indic", "Choose an Indicator", c("Choose" = "", "SMA", "EMA", "Aroon", "AroonOsc"), selectize = FALSE),
    numericInput("days", "# of days", value = "21")

  ),
  
  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
    h3(textOutput("ticker")),
    p("All data is pulled from Yahoo Finance via the Quantmod package for R."),
    p(plotOutput("chart")),
    h3("Download your stock data in CSV format"),
    p(downloadLink("download", "Download the Data"))

  )
))