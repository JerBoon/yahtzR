
make_choice <- function(game, work.mode=F) {

  print_card(game,work.mode)

  something_went_wrong <- F
  choice <- NA

  table <- game$table
  sections.available <- table$section[!is.na(table$score.available)]

  while (is.na(choice)) {

    if (!work.mode) {
      cat("Make score selection.\n- Type a scoring move from: ")
      cat(paste(sections.available, collapse=" "))
      cat("\n- type quit to, er, quit\n")
    }

    input <- tolower(readline(prompt=">> "))

    if (input == "quit") {
      return(NA)
    } else if (input %in% sections.available) {
      print(paste("you chose",input))
      table[table$section == input, "score"] <- table[table$section == input, "score.available"]
      table$score.available <- NA
      break
    }

  }

  game$table <- table
  return(game)

}
