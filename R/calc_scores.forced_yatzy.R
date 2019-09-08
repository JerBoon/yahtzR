
# Forced Yatzy has all the same rules as Yatzy, *except* that the scoring options
# must be selected in the order they appear on the card
# Therefore all we need to do is re-use all the same methods as regular Yatzy, but to
# amend the list of available options before passing in back to the user
# selection engine..


calc_scores.forced_yatzy <- function(game) {

  t <- calc_scores.yatzy(game)

  first <- min(which(!is.na(t$score.available)))
  print(first)
  t[-first,"score.available"] <- NA
  print(t)
  readline()

  return(t)
}

## ---------------------------------------------------------------

apply_bonuses.forced_yatzy <- function(game) {

  return(apply_bonuses.yatzy(game))

}
