
# Control the rolling of some dice
# returns - game object, or NA = user wants to quit

do_dice_rolls <- function(game,work.mode=F) {

  game$rolls <- 0
  something_went_qrong <- F

  while(game$rolls < 3) {

    if (game$rolls == 0) {
      game$dice <- roll_dice_once()
      game$rolls <- 1
    }

    if (!something_went_qrong) {
      if (!work.mode) {
        cat("\014")
        print_card(game,work.mode)
        cat("Enter positions of dice to reroll\n")
      } else {
        print_dice(game$dice,work.mode)
      }
    }
    something_went_qrong <- F

    input <- tolower(readline(prompt=">> "))

    if (input == "") {
      game$rolls <- 3
      break
    } else if (input == "quit") {
      return(NA)
    } else if (length(grep("^[1-5]+$",input)) == 1) {
      game$dice <- roll_dice_once(game$dice,which=input)
      game$rolls <- game$rolls + 1
    } else {
      if (work.mode) {
        cat("??\n")
      } else {
        cat("Unexpected input. Valid entries are:\n")
        cat("- integer representing the positions of dice to reroll - e.g. 123\n")
        cat("- empty string (just hit return) to accept these dice\n")
        cat("- type quit to, er, quit\n")
      }
      something_went_qrong <- T
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

print_dice <- function(d, work.mode=F) {

  c1 <- c("     ", "  o  ", "    o", "o   o", "o   o", "o   o")
  c2 <- c("  o  ", "     ", "  o  ", "     ", "  o  ", "o   o")
  c3 <- c("     ", "  o  ", "o    ", "o   o", "o   o", "o   o")

  if (work.mode) {
    print(d)
  } else {
    cat(" -----   -----   -----   -----   ----- \n")
    cat(paste0("|",c1[d[1]],"| |",c1[d[2]],"| |",c1[d[3]],"| |",c1[d[4]],"| |",c1[d[5]],"|\n"))
    cat(paste0("|",c2[d[1]],"| |",c2[d[2]],"| |",c2[d[3]],"| |",c2[d[4]],"| |",c2[d[5]],"|\n"))
    cat(paste0("|",c3[d[1]],"| |",c3[d[2]],"| |",c3[d[3]],"| |",c3[d[4]],"| |",c3[d[5]],"|\n"))
    cat(" -----   -----   -----   -----   ----- \n")
  }

}
