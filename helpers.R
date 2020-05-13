#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
#options(stringsAsFactors = FALSE)
#library(hexbin)

make_word_list = function(){
  word_list = read.csv("dictionary.csv", header=F)
  word_list = word_list %>% mutate(nchar = nchar(V1)) %>%
    filter(nchar >= 4) 
  word_list$chars =  sapply(word_list$V1, function(x) sum(!!str_count(x, letters)))
  save(word_list, file="word_list.RData")  
}

pick_today_word = function(word_list){
  today = Sys.Date()
  today = as.numeric(today)
  set.seed(today)
  today_word = sample(word_list$V1[word_list$chars==7], 1)
  return(today_word)
}

does_word_fit = function(word, letters){
  x = all( unique(strsplit(word, "")[[1]]) %in% letters)
  return(x)
}

find_all_words = function(today_word, word_list){
  letters =  unique(strsplit(today_word, "")[[1]])
  x = sapply(word_list$V1, does_word_fit, letters = letters)
  words = word_list$V1[x]
  words = words[grepl(letters[1], words)]
  return(words)
}

plot_hex = function(today_word){
  set.seed(as.numeric(Sys.time()))
  xcoords = c(.25, -.25, .75, 0, 0, .5, .5)
  ycoords = c(.25, .25, .25, -.25, .75, -.25, .75)
  letters = unique(strsplit(today_word, "")[[1]])
  center_letter = letters[1]
  other_letters = letters[-1]
  
  plot(NA, xlim=c(-.75, 1.25), ylim=c(-.75,1.25), xaxt="n", yaxt="n", xlab = "", ylab="", bty='n')  
  plotrix::hexagon(0,0,unitcell=0.5,col="gold",border="black")
  plotrix::hexagon(-.5,0,unitcell=0.5,col=NA,border="black")
  plotrix::hexagon(.5,0,unitcell=0.5,col=NA,border="black")
  plotrix::hexagon(-.25,.5,unitcell=0.5,col=NA,border="black")
  plotrix::hexagon(.25,.5,unitcell=0.5,col=NA,border="black")
  plotrix::hexagon(-.25,-.5,unitcell=0.5,col=NA,border="black")
  plotrix::hexagon(.25,-.5,unitcell=0.5,col=NA,border="black")

  
  text(x = xcoords, y=ycoords, cex=4, labels = toupper(c(center_letter, mosaic::shuffle(other_letters))))
}


calculate_point_total = function(guess){
  guess = tolower(guess)
  if(nchar(guess)==4){
    pointval = 1
  } else {
    pointval = nchar(guess)
  }
  if(length(unique(strsplit(guess, "")[[1]]))==7){
    pointval = pointval + 7
  }
  return(pointval)
}


calculate_max_score = function(words){
  x = sapply(words, calculate_point_total)
  maxpoints = sum(x)
  return(maxpoints)
}

add_success_to_list = function(guess, words, current_score, current_list){
  if(guess %in% current_list){
    return("You already found that one!")
  } else if(guess %in% words){
    current_list <<- sort(c(guess, current_list))
    pointval = calculate_point_total(guess)
    score <<- score + pointval
    print(current_list)
    print(score)
    return(paste0("Success! +", pointval, " points"))
  } else {
    return("Not a valid word")
  }
}