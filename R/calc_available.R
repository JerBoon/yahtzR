

calc_available <- function(game) {

  ### -- first calc possible scores for all scoring patterns

  # the simple scores
  t <- game$table
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
  x <- paste(sort(names(x)),sep="",collapse="")
  t[t$section == "ss","score.available"] <- (grepl("1234",x) == 1 | grepl("2345",x) | grepl("3456",x))*30
  t[t$section == "ls","score.available"] <- (x %in% c("12345","23456"))*40


  ### NA any options which have already been taken
  t$score.available[!is.na(t$score)] <- NA

  game$table <- t
  return(game)
}
