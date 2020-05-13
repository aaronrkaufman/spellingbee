source("helpers.R")
load("word_list.RData")
score <<- 0
current_list <<- c()
library(shinyjs)


function(input, output) {
  # Initialize values
  today_word = pick_today_word(word_list)
  words = find_all_words(today_word, word_list)
  max_score = calculate_max_score(words)
  
  # reactiveValues
  text_reactive <- reactiveValues(
    guess = "No guess has been submitted yet.",
    score = 0,
    current_list = c()
  )
  
  #plot_reactive <- renderPlot(
  #  plot = plot_hex(today_word)
  #)
  
  
  observeEvent(input$guess,
               {
                 
                 text_reactive$guess <- add_success_to_list(tolower(input$guess), words,
                                                            current_score = score, current_list = current_list)
                 text_reactive$score <- score
                 text_reactive$current_list <- current_list
                 shinyjs::reset("guess")
               })

  
  
  output$plot1 <- renderPlot({
    input$reshuffle
    plot_hex(today_word)
  })

  
  # This is the message indicating success or failure
  output$message <- renderText({
    text_reactive$guess
  })
  
  output$score_of_max <- renderText({
    paste0("Your score is ", text_reactive$score, " of ", max_score)
  })
  
  output$wordtable <- renderText({
    toupper(paste(text_reactive$current_list, collapse = "\n"))
  })
}