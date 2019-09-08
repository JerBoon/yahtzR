
# Control the rolling of some dice
# returns - game object, or NA = user wants to quit

do_dice_rolls <- function(game,work.mode=F) {

  game$rolls <- 0
  supply_more_info <- F

  while(game$rolls < 3) {

    if (game$rolls == 0) {
      game$dice <- roll_dice_once()
      game$rolls <- 1
    }

    if (!supply_more_info) {
      if (!work.mode) {
        cat("\014")
        print_card(game,work.mode)
        cat(paste0("Roll ",game$rolls,": Enter positions of dice to reroll\n"))
      } else {
        print_dice(game$dice, rolls=game$rolls, work.mode=work.mode)
      }
    } else {
      if (work.mode) {
        cat("??\n")
      } else {
        cat("- integer representing the positions of dice to reroll - e.g. 123\n")
        cat("- empty string (just hit return) to accept these dice\n")
        cat("- type quit to, er, quit\n")
      }
    }

      supply_more_info <- F

    input <- tolower(readline(prompt=">> "))

    if (input == "") {
      game$rolls <- 3
      break
    } else if (input == "quit") {
      return(NA)
    } else if (length(grep("^[1-5]+$",input)) == 1) {
      game$dice <- roll_dice_once(game$dice,which=input)
      game$rolls <- game$rolls + 1
    } else if (input %in% c("help","?")) {
      if (!work.mode) {
        cat("You can roll dice up to three times each turn.\n")
        cat("Select the positions of all dice you wish to reroll. Valid entries are:\n")
      }
      supply_more_info <- T
      next
    } else {
      if (!work.mode) {
        cat("Unexpected input. Valid entries are:\n")
      }
      supply_more_info <- T
      next
    }
  }

  return(game)
}

# --------------------------------------------------------------------------------------------

# "current" is a vector of the current values, if applicable
# "which" is either a character sting containing the numeric positions of the dice to re-roll
#         or if NA, all will be rolled anew

roll_dice_once <- function (current = NA, which = NA) {

  if (is.na(which)) {
    return (sample(1:6,5,replace=T))
  }

  for (i in 1:5) {
    if (length(grep(as.character(i),which)) == 1) {
      current[i] <- sample(1:6,1)
    }
  }

  return(current)

}

# --------------------------------------------------------------------------------------------

# Print the current 5 die values, either as ascii art, or if in work.mode
# as a faux vector output - "[1] 3 3 2 5 6" (where the value in bracket is actually
# the roll number - which I appreciate is a slight concession to making it look *exactly*
# like you're working... :)

print_dice <- function(d, work.mode=F, rolls) {

  if (max(is.na(d)))
    return()

  c1 <- c("     ", "  o  ", "    o", "o   o", "o   o", "o   o")
  c2 <- c("  o  ", "     ", "  o  ", "     ", "  o  ", "o   o")
  c3 <- c("     ", "  o  ", "o    ", "o   o", "o   o", "o   o")

  if (work.mode) {
    cat(paste0("[",rolls,"] "))
    cat(d)
    cat("\n")
  } else {
    cat("   -----   -----   -----   -----   ----- \n")
    cat(paste0("  |",c1[d[1]],"| |",c1[d[2]],"| |",c1[d[3]],"| |",c1[d[4]],"| |",c1[d[5]],"|\n"))
    cat(paste0("  |",c2[d[1]],"| |",c2[d[2]],"| |",c2[d[3]],"| |",c2[d[4]],"| |",c2[d[5]],"|\n"))
    cat(paste0("  |",c3[d[1]],"| |",c3[d[2]],"| |",c3[d[3]],"| |",c3[d[4]],"| |",c3[d[5]],"|\n"))
    cat("   -----   -----   -----   -----   ----- \n")
  }

}
