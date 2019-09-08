
# Get user input of chosen scoring move
# The input value of game$table will already contain scoring values
# in its score.available column - which this function uses to supply
# its vector of acceptable inputs
# Once valid option is made, the function also updates the total for that option
# and sub/grand totals

make_choice <- function(game, work.mode=F) {

  print_card(game,work.mode)
  if (!work.mode)
    cat("Select scoring option\n")

  supply_more_info <- F
  choice <- NA

  table <- game$table
  sections.available <- table$section[!is.na(table$score.available)]

  while (is.na(choice)) {

    if (!work.mode) {
      if (supply_more_info) {
        cat("- a scoring move from: ")
        cat(paste(sections.available, collapse=" "))
        cat("\n- type quit to, er, quit\n")
      }
    } else {
      if (supply_more_info)
        cat("??\n")
    }

    input <- tolower(readline(prompt=">> "))

    if (input == "quit") {
      return(NA)
    } else if (input %in% c("help","?")) {
      supply_more_info <- T
      if(!work.mode)
        cat("Select which option to score using the 2 letter code. Valid entries are:\n")
    } else if (input %in% sections.available) {
      print(paste("you chose",input))
      table[table$section == input, "score"] <- table[table$section == input, "score.available"]
      table$score.available <- NA
      break
    } else {
      supply_more_info <- T
      if(!work.mode)
        cat("Unexpected input. Valid entries are:\n")
    }

  }
  game$table <- table


  ## Apply any bonuses
  game <- apply_bonuses(game)


  ## recalculate totals
  table <- game$table
  table[table$section=="ut", "score"] <- sum(table[table$half == 1,"score"],na.rm=T)
  table[table$section=="lt", "score"] <- sum(table[table$half == 2,"score"],na.rm=T)
  table[table$section=="gt", "score"] <- sum(table[table$half %in% c(1,2),"score"],na.rm=T)

  game$table <- table
  game$dice <- NA

  return(game)

}
