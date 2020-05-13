fluidPage(
  shinyjs::useShinyjs(),
  titlePanel("R Shiny Spelling Bee"),
  sidebarLayout(
    
    sidebarPanel(
      tags$head(tags$script(src = "enter_button.js")), 
      #      sliderInput("n", "Number of points", 10, 200,
      #                  value = 50, step = 10)
      h5("Your word must be at least 4 letters long, and contain the center letter."),
      textInput("guess", "Enter Words Here", placeholder = "Your Guess Here"),
      actionButton("goButton", "Submit"),
      br(),
      br(),
      textOutput("message"),
      verbatimTextOutput("score_of_max"),
      verbatimTextOutput("wordtable")
      ),
    mainPanel(
        plotOutput("plot1", height=600, width=600)
    )
      #br(),
      #br(),
      #actionButton("reshuffle", "Reshuffle")
  )
)

#rsconnect::deployApp( appName = "Spellingbee", account="hmdc")
