
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

  ## recalculate totals etc
  table[table$section=="ub", "score"] <- (sum(table[table$section %in% c("x1","x2","x3","x4","x5","x6"),"score"],na.rm=T) >= 63)*35
  table[table$section=="ut", "score"] <- sum(table[table$half == 1,"score"],na.rm=T)
  table[table$section=="lt", "score"] <- sum(table[table$half == 2,"score"],na.rm=T)
  table[table$section=="gt", "score"] <- sum(table[table$half %in% c(1,2),"score"],na.rm=T)

  game$table <- table
  return(game)

}
