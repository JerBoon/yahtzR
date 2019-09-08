
# Ruleset for the public domain game
# Calculate available scores, given the current scorecard, and the dice rolls made
# Uses two steps
# 1 - Calculate available scores for all score types (including those already scored)
# 2 - NA any additional scores which have already been taken

calc_scores.yatzy <- function(game) {

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
  t[t$section == "3k","score.available"] <- (x[1] >= 3)*(as.integer(names(x)[1])*3)
  t[t$section == "4k","score.available"] <- (x[1] >= 4)*(as.integer(names(x)[1])*4)
  t[t$section == "yz","score.available"] <- (x[1] == 5)*50
  t[t$section == "fh","score.available"] <- (x[1] == 3)*(x[2] == 2)*sum(game$dice)
  t[t$section == "1p","score.available"] <- (x[1] >= 2)*(max(as.integer(names(x)[x >= 2]))*2)
  t[t$section == "2p","score.available"] <- (x[1] >= 2)*(length(x) > 1 & x[2] >= 2)*
                                            (sum(as.integer(names(x)[1:2]))*2)

  #and then the staights..
  #calculate ordered string of distinct die values from the frequency table
  x2 <- paste(sort(names(x)),sep="",collapse="")
  t[t$section == "ss","score.available"] <- (grepl("1234",x2) == 1 | grepl("2345",x2) | grepl("3456",x2))*30
  t[t$section == "ls","score.available"] <- (x2 %in% c("12345","23456"))*40


  ### ---- NA any options which have already been taken ----
  t$score.available[!is.na(t$score)] <- NA

  return(t)
}

## ---------------------------------------------------------------

apply_bonuses.yatzy <- function(game) {

  table <- game$table

  ## calculate upper bonus
  if (sum(table[table$section %in% c("1s","2s","3s","4s","5s","6s"),"score"],na.rm=T) >= 63) {
    table[table$section=="ub", "score"] <- 50
  } else {
    if (sum(!is.na(table[table$section %in% c("1s","2s","3s","4s","5s","6s"),"score"])) == 6)
      table[table$section=="ub", "score"] <- 0
  }

  game$table <- table

  return(game)

}
