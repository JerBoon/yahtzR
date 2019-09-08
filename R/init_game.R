
# Internal function to set up a new game
# Takes the form of a list of the various objects required
# to define current game scorecard, status, and dice rolls etc

init_game <- function(ruleset) {

  ## table for standard game scorecard

  t <- data.frame(
    half=c(1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3),
    section=c("1s","2s","3s","4s","5s","6s","ub","3k","4k","fh","ss","ls","yz","ch","ut","lt","gt"),
    name=c("Aces","Twos","Threes","Fours","Fives","Sixes","Upper bonus",
           "3 of a kind","4 of a kind","Full house","Small straight","Long straight",
           "Yahtzee","Chance",
           "Upper total","Lower total","TOTAL"),
    score=NA,
    score.available=NA,
    stringsAsFactors = F
  )

  ## Build into list object

  x <- list(
    ruleset = ruleset,
    dice = NA,
    rolls = 0,
    no_rolls_allowed = 3,
    no_dice = 5,
    table=t
  )

  ## Tweaks to setup for different rulesets

  if (ruleset == "4 rolls")
    x$no_rolls_allowed <- 4
  else if (ruleset == "5 rolls")
    x$no_rolls_allowed <- 5
  else if (ruleset == "mini")
  {
    x$no_dice <- 4
  }


  ## Done

  return(x)

}


