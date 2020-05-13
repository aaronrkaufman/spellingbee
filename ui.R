fluidPage(
  verticalLayout(
    titlePanel("R Shiny Spelling Bee"),
    column(8,
      plotOutput("plot1")
    ),
    column(4,
      verbatimTextOutput("score_of_max"),
      verbatimTextOutput("wordtable")     
    ),
    textOutput("message"),
    hr(),
    wellPanel(
#      sliderInput("n", "Number of points", 10, 200,
#                  value = 50, step = 10)
      textInput("guess", "Word", placeholder = "Your Guess Here"),
      submitButton("Submit")#,
      #br(),
      #br(),
      #actionButton("reshuffle", "Reshuffle")
    )
  )
)

rsconnect::deployApp( appName = "SpellingBee", account="hmdc")
