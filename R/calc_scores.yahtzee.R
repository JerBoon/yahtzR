
# Ruleset for the official game
# Calculate available scores, given the current scorecard, and the dice rolls made
# Uses three steps
# 1 - Calculate available sores for all score types (including those already scored)
# 2 - Apply any additional "joker" rules for subsequent yahtzees after first yahtzee has been chosen
# 3 - NA any calculated scores for any options which have already been picked

# Input = a score table
calc_scores.yahtzee <- function(game) {

  t <- game$table

  ### ---- first calc possible scores for all scoring patterns ----

  t[t$section == "1s","score.available"] <- sum(game$dice == 1) * 1
  t[t$section == "2s","score.available"] <- sum(game$dice == 2) * 2
  t[t$section == "3s","score.available"] <- sum(game$dice == 3) * 3
  t[t$section == "4s","score.available"] <- sum(game$dice == 4) * 4
  t[t$section == "5s","score.available"] <- sum(game$dice == 5) * 5
  t[t$section == "6s","score.available"] <- sum(game$dice == 6) * 6
  t[t$section == "ch","score.available"] <- sum(game$dice)

  # for the "of a kind" type scores, calculate a table of frequencies, then utilise that
  x <- sort(table(game$dice),decreasing=T)
  t[t$section == "3k","score.available"] <- (x[1] >= 3)*sum(game$dice)
  t[t$section == "4k","score.available"] <- (x[1] >= 4)*sum(game$dice)
  t[t$section == "yz","score.available"] <- (x[1] == 5)*50
  t[t$section == "fh","score.available"] <- (x[1] == 3)*(x[2] == 2)*25

  #and then the staights..
  #calculate ordered string of distinct die values from the frequency table
  x2 <- paste(sort(names(x)),sep="",collapse="")
  t[t$section == "ss","score.available"] <- (grepl("1234",x2) == 1 | grepl("2345",x2) | grepl("3456",x2))*30
  t[t$section == "ls","score.available"] <- (x2 %in% c("12345","23456"))*40

  ### ---- Apply Joker rules ----
  # As per Forced Joker rules, as stated on wikipedia page

  if (x[1] == 5 & !is.na(t[t$section == "yz","score"])) {

    # (1) yahtzee score += 100 if have already positively scored for a previous yahtzee
    if (t[t$section == "yz","score"] > 0)
      t[t$section == "yz","score"] <- t[t$section == "yz","score"] + 100

    # (2a) if the corresponding upper section is availabel - that must be selected
    if (is.na(t[t$section == paste0(names(x)[1],"s"),"score"])) {
      t[t$section != paste0(names(x)[1],"s"),"score.available"] <- NA

    # (2b) Else if lower options are avilable, must pick one of those
    # Plus fh, ls and ss are available as jokers
    } else if (sum(is.na(t[t$half == 2, "score"])) > 0) {
      t[t$half == 1, "score.available"] <- NA
      t[t$section == "fh", "score.available"] <- 25
      t[t$section == "ss", "score.available"] <- 30
      t[t$section == "ls", "score.available"] <- 40

    }
    # (2c) If no lower options available, stuck with choosing an upper

  }

  return(t)
}
