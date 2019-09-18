
# Control the rolling of some dice
# returns - game object, or NA = user wants to quit

do_dice_rolls <- function(game,work.mode=F) {

  game$rolls <- 0
  supply_more_info <- F

  rolls_allowed <- game$no_rolls_allowed
  if ("bonus_rolls" %in% names(game))
    rolls_allowed <- rolls_allowed + game$bonus_rolls


  while(game$rolls < rolls_allowed ) {

    if (game$rolls == 0) {
      game$dice <- roll_dice_once(no_dice = game$no_dice)
      game$rolls <- 1
    }

    if (!supply_more_info) {
      if (!work.mode) {
        cat("\014")
        print_card(game,work.mode)
        cat(paste0("Roll ",game$rolls,": Enter positions of dice to reroll\n"))
        if ("bonus_rolls" %in% names(game))
          cat(paste("(you have", game$bonus_rolls,"bonus rolls banked)\n"))
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
      break
    } else if (input == "quit") {
      return(NA)
    } else if (length(grep(paste0("^[1-",game$no_dice,"]+$"),input)) == 1) {
      game$dice <- roll_dice_once(no_dice = game$no_dice, current = game$dice, which=input)
      game$rolls <- game$rolls + 1
    } else if (input %in% c("help","?")) {
      if (!work.mode) {
        cat(paste("You can roll dice up to",game$no_rolls_allowed,"times each turn.\n"))
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

  if ("bonus_rolls" %in% names(game))
    game$bonus_rolls <- rolls_allowed - game$rolls
#  game$rolls <- game$no_rolls_allowed

  return(game)
}

# --------------------------------------------------------------------------------------------

# "no_dice" is the number of dice available (i.e. 5 in a standard game)
# "current" is a vector of the current values, if applicable
# "which" is either a character sting containing the numeric positions of the dice to re-roll
#         or if NA, all will be rolled anew

roll_dice_once <- function (no_dice, current = NA, which = NA) {

  if (is.na(which)) {
    return (sample(1:6, no_dice, replace=T))
  }

  for (i in 1:no_dice) {
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
    box <- ""
    line1 <- ""
    line2 <- ""
    line3 <- ""
    for (i in 1:length(d))
    {
      box <- paste0(box,"  ----- ")
      line1 <- paste0(line1, " |", c1[d[i]],"|")
      line2 <- paste0(line2, " |", c2[d[i]],"|")
      line3 <- paste0(line3, " |", c3[d[i]],"|")
    }
    cat(sprintf(" %s\n %s\n %s\n %s\n %s\n", box, line1, line2, line3,box))
  }

}
