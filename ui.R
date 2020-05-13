fluidPage(
  shinyjs::useShinyjs(),
  verticalLayout(
    titlePanel("R Shiny Spelling Bee"),
    column(8,
      plotOutput("plot1", height=600, width=600)
    ),
    column(4,
      verbatimTextOutput("score_of_max"),
      verbatimTextOutput("wordtable")     
    ),
    textOutput("message"),
    hr(),
    wellPanel(
      tags$head(tags$script(src = "enter_button.js")), 
#      sliderInput("n", "Number of points", 10, 200,
#                  value = 50, step = 10)
      textInput("guess", "Word", placeholder = "Your Guess Here"),
      actionButton("goButton", "Submit")#,
      #br(),
      #br(),
      #actionButton("reshuffle", "Reshuffle")
    )
  )
)

#rsconnect::deployApp( appName = "Spellingbee", account="hmdc")
