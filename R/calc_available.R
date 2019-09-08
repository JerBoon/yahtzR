
# Calculate available scores, given the current scorecard, and the dice rolls made
# Uses three steps
# 1 - Calculate available sores for all score types (including those already scored)
# 2 - Apply any additional "joker" rules for subsequent yahtzees after first yahtzee has been chosen
# 3 - NA any calculated scores for any options which have already been picked

calc_available <- function(game) {

  ### ---- first calc possible scores for all scoring patterns, using the appropriate rules ----

  #print(game)
  t <- calc_scores(game)
  #t <- calc_scores.yahtzee(game)

  game$table <- t
  return(game)
}
