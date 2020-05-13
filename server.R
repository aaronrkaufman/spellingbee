function(input, output) {
  source("helpers.R")
  load("word_list.RData")
  library(shinyjs)
  
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
  

  observeEvent(input$goButton,
              {

                if(tolower(input$guess) %in% text_reactive$current_list){
                  text_reactive$guess <- "You already found that one!"
                } else if(tolower(input$guess) %in% words){
                  text_reactive$current_list <- sort(c(tolower(input$guess), text_reactive$current_list))
                  pointval = calculate_point_total(tolower(input$guess))
                  text_reactive$score <- text_reactive$score + pointval
                  text_reactive$guess = paste0("Success! +", pointval, " points")
                } else {
                  text_reactive$guess = "Not a valid word"
                }                 
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