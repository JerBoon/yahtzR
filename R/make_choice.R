
# Get user input of chosen scoring move
# The input value of game$table will already contain scoring values
# in its score.available column - which this function uses to supply
# its vector of acceptable inputs
# Once valid option is made, the function also updates the total for that option
# and sub/grand totals

make_choice <- function(game, work.mode=F) {

  table <- game$table

  # If only one choice, do it, with relevant prompting
  auto_pick <- F
  if (sum(!is.na(table$score.available)) == 1)
    auto_pick <- T

  print_card(game,work.mode)

  if (!work.mode & !auto_pick)
    cat("Select scoring option\n")

  supply_more_info <- F
  choice <- NA

  sections.available <- table$section[!is.na(table$score.available)]

  while (is.na(choice)) {

    if (auto_pick) {
      # only one option available - choose it automatically
      input <- table[order(table$score.available,decreasing=T)[1],"section"]
      # Message, and slight pause so the user gets some feedback rather
      # than just seeing another dice roll..
      if (!work.mode) {
        cat(paste("Selecting",input))
        Sys.sleep(0.6)
      }
    } else {
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
    }

    if (input == "quit") {
      return(NA)
    } else if (input %in% c("help","?")) {
      supply_more_info <- T
      if(!work.mode)
        cat("Select which option to score using the 2 letter code. Valid entries are:\n")
    } else if (input == "test") {
      print(game$table)
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

  #update running total and choice order info
  table[table$section == input, "score.running"] <- table[table$section=="gt", "score"]
  table[table$section == input, "score.sequence"] <- sum(!is.na(table$score.running))

  game$table <- table
  game$dice <- NA

  return(game)

}
