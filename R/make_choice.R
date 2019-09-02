
# Get user input of chosen scoring move
# The input value of game$table will already contain scoring values
# in its score.available column - which this function uses to supply
# its vector of acceptable inputs
# Once valid option is made, the function also updates the total for that option
# and sub/grand totals

make_choice <- function(game, work.mode=F) {

  print_card(game,work.mode)

  something_went_wrong <- F
  choice <- NA

  table <- game$table
  sections.available <- table$section[!is.na(table$score.available)]

  while (is.na(choice)) {

    if (!work.mode) {
      if (!something_went_wrong) {
        cat("Make score selection.\n")
      } else {
        cat("Unexpected input. Valid entries are:\n")
        cat("- a scoring move from: ")
        cat(paste(sections.available, collapse=" "))
        cat("\n- type quit to, er, quit\n")
      }
    } else {
      if (something_went_wrong)
        cat("??\n")
    }

    input <- tolower(readline(prompt=">> "))

    if (input == "quit") {
      return(NA)
    } else if (input %in% sections.available) {
      print(paste("you chose",input))
      table[table$section == input, "score"] <- table[table$section == input, "score.available"]
      table$score.available <- NA
      break
    } else {
      something_went_wrong <- T
    }

  }

  ## calculate upper bonus
  if (sum(table[table$section %in% c("1s","2s","3s","4s","5s","6s"),"score"],na.rm=T) >= 63) {
    table[table$section=="ub", "score"] <- 35
  } else {
    if (sum(!is.na(table[table$section %in% c("1s","2s","3s","4s","5s","6s"),"score"])) == 6)
      table[table$section=="ub", "score"] <- 0
  }

  ## recalculate totals
  table[table$section=="ut", "score"] <- sum(table[table$half == 1,"score"],na.rm=T)
  table[table$section=="lt", "score"] <- sum(table[table$half == 2,"score"],na.rm=T)
  table[table$section=="gt", "score"] <- sum(table[table$half %in% c(1,2),"score"],na.rm=T)

  game$table <- table
  game$dice <- NA

  return(game)

}
